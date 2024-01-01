function sendXrayFile(file) {
  var formData = new FormData();
  formData.append("file", $("#f_UploadImage")[0].files[0]);
  $.ajax({
    type: "post",
    url: "uploader.ashx",
    data: formData,
    success: function (status) {
      if (status != "error") {
        var my_path = "../lab/image-results/xray/normal/" + status;
        SaveXrayImage(my_path);
        document.getElementById("xrayImgPathSpan").innerText =
          "../hms.ui/app/lab/image-results/xray/normal/" + status;
        $("#xrayImgSrc").attr("height", "100%");
        $("#xrayImgSrc").attr("width", "100%");
        $("#xrayImgSrc").attr("src", my_path);
        document.getElementById("xrayImageStatus").style.display = "none";
        $("#imageUplaodModal").modal("hide");
      }
    },
    processData: false,
    contentType: false,
    error: function () {
      alert("Whoops something went wrong!");
    },
  });
}
function sendMRIFile(file) {
    var formData = new FormData();
    formData.append("file", $("#mriUloader")[0].files[0]);
    $.ajax({
        type: "post",
        url: "mriuploader.ashx",
        data: formData,
        success: function (status) {
            if (status != "error") {
                var my_path = "../lab/image-results/mri/normal/" + status;
                SaveXrayImage(my_path);
                document.getElementById("mriImgPathSpan").innerText =
                    "../hms.ui/app/lab/image-results/mri/normal/" + status;
                $("#mriImgSrc").attr("height", "100%");
                $("#mriImgSrc").attr("width", "100%");
                $("#mriImgSrc").attr("src", my_path);
                document.getElementById("mriImageStatus").style.display = "none";
                $("#MRIImageUplaodModal").modal("hide");
            }
        },
        processData: false,
        contentType: false,
        error: function () {
            alert("Whoops something went wrong!");
        },
    });
}
var _URL = window.URL || window.webkitURL;
$("#f_UploadImage").on("change", function () {
  var file, img;
  if ((file = this.files[0])) {
    img = new Image();
    img.onload = function () {
        sendXrayFile(file);
    };
    img.onerror = function () {
      alert("Not a valid file:" + file.type);
    };
    img.src = _URL.createObjectURL(file);
  }
});
$("#mriUloader").on("change", function () {
    var file, img;
    if ((file = this.files[0])) {
        img = new Image();
        img.onload = function () {
            sendMRIFile(file);
        };
        img.onerror = function () {
            alert("Not a valid file:" + file.type);
        };
        img.src = _URL.createObjectURL(file);
    }
});
function SaveXrayImage(imagePath) {
  let regNo = "001";
  let imageType = "Xray";
  PageMethods.SaveXrayImage(regNo, imageType, imagePath);
}
