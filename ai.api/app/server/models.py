import torch
import torchxrayvision as xrv
import skimage
import torch
import torchvision
import json
import numpy as np


class XrayClassifier(object):
    def __init__(self) -> None:
        pass
    def transform_image(img_path):
        img = skimage.io.imread(img_path)
        # convert 8-bit image to [-1024, 1024] range
        img = xrv.datasets.normalize(img, 255)
        img = img.mean(2)[None, ...]  # Make single color channel
        transform = torchvision.transforms.Compose(
            [xrv.datasets.XRayCenterCrop(), xrv.datasets.XRayResizer(224)])
        img = transform(img)
        img = torch.from_numpy(img)
        return img
    def predict(model_type, img_path):
        img = XrayClassifier.transform_image(img_path=img_path)
        if model_type == "rsna":
            # RSNA Pneumonia Challenge
            model = xrv.models.DenseNet(weights="densenet121-res224-rsna")
            outputs = model(img[None, ...])
            formatted = dict(
                zip(model.pathologies, np.float64(outputs[0].detach().numpy())))
            return formatted
        elif model_type == "all":
            # Model Trained From Different Datasets
            model = xrv.models.DenseNet(weights="densenet121-res224-all")
            outputs = model(img[None, ...])
            formatted = dict(
                zip(model.pathologies, np.float64(outputs[0].detach().numpy())))
            return formatted
        elif model_type == "chex":
            # CheXpert (Stanford)
            model = xrv.models.DenseNet(
                weights="densenet121-res224-chex")
            outputs = model(img[None, ...])
            formatted = dict(
                zip(model.pathologies, np.float64(outputs[0].detach().numpy())))
            return formatted
        else:
            # PCAM Model
            model = xrv.baseline_models.jfhealthcare.DenseNet()
            outputs = model(img[None, ...])
            formatted = dict(
                zip(model.pathologies, np.float64(outputs[0].detach().numpy())))
            return formatted


# pred = XrayClassifier.predict(
#     model_type="all", img_path="../hms.ui/app/lab/image-results/xray/normal/pnu1.jpeg")
# print(pred)
