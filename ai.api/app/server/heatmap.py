from glob import glob
import matplotlib.pyplot as plt
import numpy as np
import skimage.io
import torchxrayvision as xrv
import numpy as np
import matplotlib.pyplot as plt
import torch
import torchvision
from torch import argmax, load
import datetime


class HeatmapGenerator(object):
    def __init__(self) -> None:
        pass

    def get_top_one_prediction(arr, patarr):
        class_id = argmax(arr.data, dim=1)
        pm = arr[0].detach().numpy()[class_id]
        lb = patarr[class_id]
        return lb, pm

    def transform_image(model_type, img_path):
        img = skimage.io.imread(img_path)
        img = xrv.datasets.normalize(img, 255)
        # Check that images are 2D arrays
        if len(img.shape) > 2:
            img = img[:, :, 0]
        if len(img.shape) < 2:
            print("error, dimension lower than 2 for image")
        img = img[None, :, :]
        # Add color channel
        if model_type == "rsna" or model_type == "all" or model_type == "chex":
            transform = torchvision.transforms.Compose(
                [xrv.datasets.XRayCenterCrop(), xrv.datasets.XRayResizer(224)])
            img = transform(img)
            img = torch.from_numpy(img).unsqueeze(0)
        else:
            transform = torchvision.transforms.Compose(
                [xrv.datasets.XRayCenterCrop(), xrv.datasets.XRayResizer(512)])
            img = transform(img)
            img = torch.from_numpy(img).unsqueeze(0)
        return img

    def build_model(model_type):
        if model_type == "rsna":
            # RSNA Pneumonia Challenge
            model = xrv.models.DenseNet(weights="densenet121-res224-rsna")
            return model
        elif model_type == "all":
            # Model Trained From Different Datasets
            model = xrv.models.DenseNet(weights="densenet121-res224-all")
            return model
        elif model_type == "chex":
            # CheXpert (Stanford)
            model = xrv.models.DenseNet(
                weights="densenet121-res224-chex")
            return model
        else:
            # PCAM Model
            model = xrv.baseline_models.jfhealthcare.DenseNet()
            return model

    def create_heatmap(model_type, img_path):
        model = HeatmapGenerator.build_model(model_type=model_type)
        img = HeatmapGenerator.transform_image(
            model_type=model_type, img_path=img_path)
        img = img.requires_grad_()
        outputs = model(img)
        lb, _ = HeatmapGenerator.get_top_one_prediction(
            outputs, model.pathologies)
        target = model.pathologies.index(lb)
        grads = torch.autograd.grad(outputs[:, target], img)[0][0][0]
        blurred = skimage.filters.gaussian(
            grads.detach().cpu().numpy()**2, sigma=(5, 5), truncate=3.5)
        my_dpi = 200
        fig = plt.figure(frameon=False, figsize=(
            1000/my_dpi, 1000/my_dpi), dpi=my_dpi)
        ax = plt.Axes(fig, [0., 0., 1., 1.])
        ax.set_axis_off()
        fig.add_axes(ax)
        ax.imshow(img[0][0].detach().cpu().numpy(), cmap="gray", aspect='auto')
        ax.imshow(blurred, alpha=0.5)
        file_name = "xray_heatmaps_" +lb+"_"+ str(datetime.date.today()) + ".png"
        print(file_name)
        print(_)
        fig.savefig(
            "../hms.ui/app/lab/image-results/xray/heatmap/"+file_name)
        return file_name


