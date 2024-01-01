<%@ Page Title="" Language="C#" MasterPageFile="~/app/opd/app.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="hms.ui.app.opd.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Dashboard</title>
    <script src="../../assets/js/tf.min.js"></script>
    <script src="../../assets/ckeditor/ckeditor.js"></script>
    <link href="../../assets/ckeditor/toolbarconfigurator/lib/codemirror/neo.css" rel="stylesheet" />
    <script src="../../assets/ckeditor/samples/js/sample.js"></script>
    <link href="../../assets/select2/dist/css/select2.min.css" rel="stylesheet" />
    <script src="../../assets/tinymce/tinymce.min.js"></script>
    <link href="../../assets/zoom/fancybox.css" rel="stylesheet" />
    <style>
* {box-sizing: border-box;}

.img-magnifier-container {
  position:relative;
}

.img-magnifier-glass {
  position: absolute;
  border: 3px solid #000;
  border-radius: 50%;
  cursor: none;
  /*Set the size of the magnifier glass:*/
  width: 100px;
  height: 100px;
}
</style>
    <script>
        function magnify(imgID, zoom) {
            var img, glass, w, h, bw;
            img = document.getElementById(imgID);
            /*create magnifier glass:*/
            glass = document.createElement("DIV");
            glass.setAttribute("class", "img-magnifier-glass");
            /*insert magnifier glass:*/
            img.parentElement.insertBefore(glass, img);
            /*set background properties for the magnifier glass:*/
            glass.style.backgroundImage = "url('" + img.src + "')";
            glass.style.backgroundRepeat = "no-repeat";
            glass.style.backgroundSize = (img.width * zoom) + "px " + (img.height * zoom) + "px";
            bw = 3;
            w = glass.offsetWidth / 2;
            h = glass.offsetHeight / 2;
            /*execute a function when someone moves the magnifier glass over the image:*/
            glass.addEventListener("mousemove", moveMagnifier);
            img.addEventListener("mousemove", moveMagnifier);
            /*and also for touch screens:*/
            glass.addEventListener("touchmove", moveMagnifier);
            img.addEventListener("touchmove", moveMagnifier);
            function moveMagnifier(e) {
                var pos, x, y;
                /*prevent any other actions that may occur when moving over the image*/
                e.preventDefault();
                /*get the cursor's x and y positions:*/
                pos = getCursorPos(e);
                x = pos.x;
                y = pos.y;
                /*prevent the magnifier glass from being positioned outside the image:*/
                if (x > img.width - (w / zoom)) { x = img.width - (w / zoom); }
                if (x < w / zoom) { x = w / zoom; }
                if (y > img.height - (h / zoom)) { y = img.height - (h / zoom); }
                if (y < h / zoom) { y = h / zoom; }
                /*set the position of the magnifier glass:*/
                glass.style.left = (x - w) + "px";
                glass.style.top = (y - h) + "px";
                /*display what the magnifier glass "sees":*/
                glass.style.backgroundPosition = "-" + ((x * zoom) - w + bw) + "px -" + ((y * zoom) - h + bw) + "px";
            }
            function getCursorPos(e) {
                var a, x = 0, y = 0;
                e = e || window.event;
                /*get the x and y positions of the image:*/
                a = img.getBoundingClientRect();
                /*calculate the cursor's x and y coordinates, relative to the image:*/
                x = e.pageX - a.left;
                y = e.pageY - a.top;
                /*consider any page scrolling:*/
                x = x - window.pageXOffset;
                y = y - window.pageYOffset;
                return { x: x, y: y };
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row mx-2">

        <div class="col-xl-7 mb-2 mt-2  ">
            <div class="bg-white" style="border-radius: 19px">
                <asp:Button ID="Button1" runat="server" Text="Button" Visible="false" OnClick="Button1_Click" />
                <div class="card-header bg-white " style="border-radius: 19px">
                    <div class="row align-items-center">
                        <div class="col-8">
                            <div class="text-xs font-we ight-bolder text-primary  text-uppercase mb-1">
                                Disease Analysis <span class="text-gray-400 badge badge-light small">Current Session</span>
                                <span id="Span1" runat="server" visible="false" class="mb-1 small font-italic text-danger"></span><span id="Span7" visible="false" class="mb-1 mr-2 ml-2 mb-1 small font-italic text-danger" runat="server">-</span><span id="Span8" visible="false" class="mb-1 small font-italic text-danger" runat="server"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" style="zoom: 90%">
                    <div class="col-md-4 col-sm-12">
                        <div class="chart-pie mt-3 mx-3" style="height: 200px; width: 200px;">
                            <canvas id="diseaseChart"></canvas>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="row mt-5">
                            <div class="col-xl-3">
                                <div class="card mt-3 small shadow-none" style="border-radius: 15px; background-color: #a035e110; width: 105px">
                                    <div class="card-body">

                                        <span class="bi bi-person-circle  btn-sm bg-white fa-2x" style="border-radius: 7px; color: #c34dc150"></span>
                                        <br />
                                        <br />

                                        <span class="text-gray-700 font-weight-bold font-weight-light small" data-toggle="modal" data-target="#MRIModal">Male</span>
                                        <br />
                                        <span class="text-gray-600  mb-3 h6 mt-3 font-weight-bolder" id="requestCount">0</span>

                                    </div>
                                </div>

                            </div>
                            <div class="col-xl-3">
                                <div class="card mt-3 small" style="border-radius: 15px; background-color: #fbb71410; width: 105px">
                                    <div class="card-body">

                                        <span class="bi bi-person-heart  btn-sm bg-white fa-2x" style="border-radius: 7px; color: #c34dc150"></span>
                                        <br />
                                        <br />

                                        <span class="text-gray-700 font-weight-bold font-weight-light small">Female</span>
                                        <br />
                                        <span class="text-gray-600  mb-3 h6 mt-3 font-weight-bolder" id="requestCount">0</span>

                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3">
                                <div class="card mt-3 small" style="border-radius: 15px; background-color: #56829310; width: 105px">
                                    <div class="card-body">

                                        <span class="bi bi-person-heart  btn-sm bg-white fa-2x" style="border-radius: 7px; color: #c34dc150"></span>
                                        <br />
                                        <br />

                                        <span class="text-gray-700 font-weight-bold font-weight-light small" data-toggle="modal" data-target="#XrayModal">Request</span>
                                        <br />
                                        <span class="text-gray-600  mb-3 h6 mt-3 font-weight-bolder" id="requestCount">0</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3">
                                <div class="card mt-3 small" style="border-radius: 15px; background-color: #56829310; width: 105px">
                                    <div class="card-body">

                                        <span class="bi bi-person-heart  btn-sm bg-white fa-2x" style="border-radius: 7px; color: #c34dc150"></span>
                                        <br />
                                        <br />

                                        <span class="text-gray-700 font-weight-bold font-weight-light small">Request</span>
                                        <br />
                                        <a data-toggle="modal" href="#" onclick="GetRequestDetails()" data-target="#RequestModal">
                                            <span class="text-gray-600  mb-3 h6 mt-3 font-weight-bolder" id="requestCount">0</span>


                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                 
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-5 mb-2 mt-2  ">
            <div class="bg-white rounded-lg" id="div_print">
                <div class="card-header bg-white " style="border-radius: 19px">
                    <div class="row align-items-center">
                        <div class="col-8">
                            <div class="text-xs font-weight-bolder text-primary  text-uppercase mb-1">
                                Patient By Gender <span class="text-gray-400 badge badge-light small">Current Session</span>
                                <span id="Span9" runat="server" visible="false" class="mb-1 small font-italic text-danger"></span><span id="Span10" visible="false" class="mb-1 mr-2 ml-2 mb-1 small font-italic text-danger" runat="server">-</span><span id="Span11" visible="false" class="mb-1 small font-italic text-danger" runat="server"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" style="zoom: 90%">
                    <div class="col-md-8 col-sm-12">
                        <div class="chart-pie mt-3 mx-3" style="height: 200px; width: 200px;">
                            <canvas id="requestChart"></canvas>
                        </div>
                    </div>
                    <div class="col-md-7">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row mx-2">
        <div class="col-lg-6">
            <div class="bg-white" style="border-radius: 19px">
                <div class="card-header bg-white " style="border-radius: 19px">
                    <div class="row align-items-center">
                        <div class="col-8">
                            <div class="text-xs font-weight-bolder text-primary  text-uppercase mb-1">
                                Request Progress <span class="text-gray-400 badge badge-light small">Current Session</span>
                                <span id="datFromc" runat="server" visible="false" class="mb-1 small font-italic text-danger"></span><span id="tomiddlec" visible="false" class="mb-1 mr-2 ml-2 mb-1 small font-italic text-danger" runat="server">-</span><span id="datToc" visible="false" class="mb-1 small font-italic text-danger" runat="server"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="progress" style="height: 15px">
                        <div class="progress-bar" style="background-color:#ff8b8b" role="progressbar" id="requestPending" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                        <div class="progress-bar bg-warning" id="requestExamining" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <hr />
                    <div class="row align-content-md-center">
                        <div class="col-md-3 col-sm-6">
                            <div class="row mb-2 ">
                                <div class="col-12 mb-2">
                                    <span class="bi bi-check-circle text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                    <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Pending</span>
                                    <span class="font-weight-bold text-xs  text-right" style="color: #ff8b8b" id="pendingRequest">0</span>

                                </div>
                            </div>
                            
                        </div>
                        <div class="col-md-9 col-sm-6">
                            <div class="row mb-2 ">
                                <div class="col-12 mb-2 text-right">
                                    <span class="bi bi-check-circle text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                    <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Examining</span>
                                    <span class="font-weight-bold text-xs text-uppercase text-right  text-warning" id="examiningRequest">0</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="bg-white" style="border-radius: 19px">
                <div class="card-header bg-white " style="border-radius: 19px">
                    <div class="row align-items-center">
                        <div class="col-8">
                            <div class="text-xs font-weight-bolder text-primary  text-uppercase mb-1">
                                Diagnosis Progress <span class="text-gray-400 badge badge-light small">Current Session</span>
                                <span id="Span2" runat="server" visible="false" class="mb-1 small font-italic text-danger"></span><span id="Span3" visible="false" class="mb-1 mr-2 ml-2 mb-1 small font-italic text-danger" runat="server">-</span><span id="Span4" visible="false" class="mb-1 small font-italic text-danger" runat="server"></span>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="card-body">
                    <div class="progress" style="height: 15px">
                        <div class="progress-bar bg-primary progress-bar-striped progress-bar-animated" role="progressbar" id="Div1" runat="server" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                        <div class="progress-bar bg-warning progress-bar-striped progress-bar-animated" id="Div2" runat="server" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>

                    <hr />
                    <div class="row align-content-md-center">
                        <div class="col-md-3 col-sm-6">
                            <div class="row mb-2 ">
                                <div class="col-12 mb-2">
                                    <span class="bi bi-check-circle text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                    <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Pending</span>
                                    <span class="font-weight-bold text-xs  text-right" style="color: #ff8b8b" id="Span5" runat="server">0</span>

                                </div>
                            </div>

                        </div>
                        <div class="col-md-9 col-sm-6">
                            <div class="row mb-2 ">
                                <div class="col-12 mb-2 text-right">
                                    <span class="bi bi-check-circle text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                    <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Examining</span>
                                    <span class="font-weight-bold text-xs text-uppercase text-right  text-warning" id="Span6" runat="server">0</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
    <div class="modal fade" id="RequestModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-patch-exclamation mr-2" style="color: #c34dc1; font-size: 20px"></span>
                        Diagnosis Requests</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                    <div class="row mb-2">
                        <div class="col-md-12 small">
                            <a href="#" onclick="BackToHistory()">
                                <span class="bi bi-chevron-left"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1">Back</span>
                            </a>
                            <a href="#" data-toggle="modal" data-target="#SessionModal" id="session">
                                <span class="bi bi-check-circle"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Close all current session">Close Session</span>
                            </a>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 small">
                            <table class="table align-items-center table-hover table-sm " style="zoom: 85%;" id="requestTable">
                            </table>
                            <center>
                                <main role="main" id="requestDiv" style="display: none">

                                    <div class="starter-template">
                                        <center>
                                            <p class="lead">
                                                <i class="bi bi-send-dash text-gray-300  fa-3x"></i>
                                            </p>
                                            <h6 class="text-gray-700 small">No Request</h6>
                                        </center>
                                    </div>
                                </main>
                            </center>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="ExamineModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-patch-exclamation mr-2" style="color: #c34dc1; font-size: 22px"></span>
                        Examine Patient [Reg#<span id="regNumber"></span>]</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="height: 470px; overflow-y: scroll">
                    <div class="row mb-2 small">
                        <div class="col-12 mb-2">
                            <span class="bi bi-check-circle text-gray-500 " data-toggle="tooltip" title="Dose and Notes"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1">Lab Tests</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 small">
                            <table class="table table-sm">
                                <tbody>
                                    <tr class="border-bottom">
                                        <td>
                                            <span class="bi bi-check-circle" style="color: #c34dc1;" data-toggle="tooltip" title="Notes"></span>
                                            <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Enable Email Automation">Bio-Chemistry</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                <input type="checkbox" class="custom-control-input" id="bioChemCheckBox" runat="server" clientidmode="Static" />

                                                <label class="custom-control-label text-gray-700 small " for="bioChemCheckBox">Mark</label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="border-bottom">
                                        <td>
                                            <span class="bi bi-check-circle" style="color: #c34dc1;" data-toggle="tooltip" title="Notes"></span>
                                            <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Enable Email Automation">Stool</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                <input type="checkbox" class="custom-control-input" id="stoolCheckBox" runat="server" clientidmode="Static" />

                                                <label class="custom-control-label text-gray-700 small " for="stoolCheckBox">Mark</label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="border-bottom">
                                        <td>
                                            <span class="bi bi-check-circle" style="color: #c34dc1;" data-toggle="tooltip" title="Notes"></span>
                                            <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Enable Email Automation">Blood</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                <input type="checkbox" class="custom-control-input" id="bloodChechBox" runat="server" clientidmode="Static" />
                                                <label class="custom-control-label text-gray-700 small " for="bloodChechBox">Mark</label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="border-bottom">
                                        <td>
                                            <span class="bi bi-check-circle" style="color: #c34dc1;" data-toggle="tooltip" title="Notes"></span>
                                            <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Enable Email Automation">Colonscopy</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                <input type="checkbox" class="custom-control-input" id="colonCheckBox" runat="server" clientidmode="Static" />
                                                <label class="custom-control-label text-gray-700 small " for="colonCheckBox">Mark</label>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-4 small">
                            <table class="table table-sm">
                                <tbody>
                                    <tr class="border-bottom">
                                        <td>
                                            <span class="bi bi-check-circle" style="color: #c34dc1;" data-toggle="tooltip" title="Notes"></span>
                                            <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Enable Email Automation">Gastroscopy</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                <input type="checkbox" class="custom-control-input" id="gastrosCheckBox" runat="server" clientidmode="Static" />
                                                <label class="custom-control-label text-gray-700 small " for="gastrosCheckBox">Mark</label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="border-bottom">
                                        <td>
                                            <span class="bi bi-check-circle" style="color: #c34dc1;" data-toggle="tooltip" title="Notes"></span>
                                            <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Enable Email Automation">Urine</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                <input type="checkbox" class="custom-control-input" id="urineCheckBox" runat="server" clientidmode="Static" />
                                                <label class="custom-control-label text-gray-700 small " for="urineCheckBox">Mark</label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="border-bottom">
                                        <td>
                                            <span class="bi bi-check-circle" style="color: #c34dc1;" data-toggle="tooltip" title="Notes"></span>
                                            <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Enable Email Automation">X-Ray</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                <input type="checkbox" class="custom-control-input" id="xrayChechBox" runat="server" clientidmode="Static" />
                                                <label class="custom-control-label text-gray-700 small " for="xrayChechBox">Mark</label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="border-bottom">
                                        <td>
                                            <span class="bi bi-check-circle" style="color: #c34dc1;" data-toggle="tooltip" title="Notes"></span>
                                            <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Enable Email Automation">Sonography</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                <input type="checkbox" class="custom-control-input" id="sonogCheckBox" runat="server" clientidmode="Static" />
                                                <label class="custom-control-label text-gray-700 small " for="sonogCheckBox">Mark</label>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-4 small">
                            <table class="table table-sm">
                                <tbody>
                                    <tr class="border-bottom">
                                        <td>
                                            <span class="bi bi-check-circle" style="color: #c34dc1;" data-toggle="tooltip" title="Notes"></span>
                                            <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Enable Email Automation">ECG</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                <input type="checkbox" class="custom-control-input" id="ecgCheckBox" runat="server" clientidmode="Static" />
                                                <label class="custom-control-label text-gray-700 small " for="ecgCheckBox">Mark</label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="border-bottom">
                                        <td>
                                            <span class="bi bi-check-circle" style="color: #c34dc1;" data-toggle="tooltip" title="Notes"></span>
                                            <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Enable Email Automation">Other</span>
                                        </td>
                                        <td class="text-right">
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                <input type="checkbox" class="custom-control-input" id="otherCheckBox" runat="server" clientidmode="Static" />
                                                <label class="custom-control-label text-gray-700 small " for="otherCheckBox">Mark</label>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 small">
                            <div style="height: 90px">
                                <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Dose and Notes"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Laboratory Tests">Remarks</span>
                                <div style="zoom: 80%">
                                    <textarea id="examinationEditor"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-link   btn-sm" type="button" onclick="ExamineWithoutTest()">
                        Examine Without Test <span class="text-right mx-2 bi bi-arrow-90deg-right" style="color: #8bb0cf7f"></span>
                    </button>
                    <button class="btn  btn-sm text-white" onclick="$('#ExamineModal').modal('hide')" type="button" data-target="#AIModal" data-toggle="modal" style="border-radius: 14px; background-color: #ba99d4">
                        <span class="bi bi-boxes mr-2"></span>AI Examination
                    </button>
       
                    <button class="btn  btn-sm text-white" type="button" onclick="SendTestRequest()" style="border-radius: 14px;background-color:#ba99d4">
                        <span class="bi bi-send-check mr-2"></span>Send Test
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="HistoryModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="border-radius: 18px;">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-clipboard-check mr-2" style="color: #c34dc1; font-size: 22px"></span>
                        Add Diagnostic History [Reg#<span id="regHistoryNumber"></span>]</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 800px; overflow-y: scroll">
                    <div class="row">
                        <div class="col-md-12 small">
                            <a href="#" onclick="GetDiagnosisRequest()">
                                <span class="bi bi-r-circle"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="modal" data-target="#TestRequestModal">Results</span>
                            </a>
                            <a href="#" data-toggle="modal" data-target="#MedicineModal">
                                <span class="bi bi-collection"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Medicine Catelog">Med Catalog</span>
                            </a>
                            <a href="#" data-toggle="modal" data-target="#DiseaseModal">
                                <span class="bi bi-collection"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Disease Catelog">Disease Catalog</span>
                            </a>
                            <a href="#" data-toggle="modal" data-target="#AppointmentModal">
                                <span class="bi bi-clock"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Add Apointnment">Appointment</span>
                            </a>
                            <a href="#" data-toggle="modal" data-target="#InjectionModal">
                                <span class="bi bi-pen"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Add Injection Schedule">Injection</span>
                            </a>
                            <a href="#" onclick="ShowPatientHistory()">
                                <span class="bi bi-clock-history"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="See Patient History">History</span>
                            </a>
                            <a href="#" data-toggle="modal" data-target="#FollUpModal">
                                <span class="bi bi-file-earmark-check"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Create Follow Up">Follow Up</span>
                            </a>
                            <a href="#" onclick="ShowPatientHistory()">
                                <span class="bi bi-file-earmark-medical"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Create Refer">Refer</span>
                            </a>
                            <br />
                            <br />
                            <div style="zoom:80%">
                                <textarea id="historyEditor"></textarea>
                            </div>
                            <script>
                                CKEDITOR.replace('editor');
                            </script>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm text-white" type="button" onclick="EndDiagSession()" style="border-radius: 2px; background-color: #ba99d4">
                        <span class="bi bi-save2 mr-2"></span>Save and End Session
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="PatientHistoryModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content" style="border-radius: 18px;">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-clock-history mr-2" style="color: #c34dc1; font-size: 22px"></span>
                        Patient History [Reg#<span id="regPatientHistoryNumber"></span>]</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12 small">
                            <a href="#" onclick="BackToHistory()">
                                <span class="bi bi-chevron-left"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1">Back</span>
                            </a>
                            <a href="#">
                                <span class="bi bi-file-pdf"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Add Apointnment">Export Pdf</span>
                            </a>
                            <a href="#">
                                <span class="bi bi-file-word"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Add Injection Schedule">Export Word</span>
                            </a>
                            <a href="#">
                                <span class="bi bi-send-check"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Add Injection Schedule">Send Email</span>
                            </a>
                            <a href="#">
                                <span class="bi bi-pie-chart"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Add Injection Schedule">Analytics</span>
                            </a>
                        </div>
                    </div>
                    <hr />
                    <div class="row" style="max-height: 400px; overflow-y: scroll">
                        <div class="col-md-12" id="historyDiv">
                            <table class="table align-items-center table-hover table-sm table-bordered" style="zoom:65%" id="historyTable">
                            </table>
                            <main role="main" id="historyStatusDiv" style="display: none">

                                <div class="starter-template">
                                    <center>
                                        <p class="lead">
                                            <i class="bi bi-person-exclamation text-gray-300  fa-3x"></i>
                                        </p>
                                        <h6 class="text-gray-700 small">No Patient History Found</h6>
                                    </center>
                                </div>
                            </main>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="TestRequestModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-speedometer mr-2" style="font-size: 22px; color: #ef2d7a"></span>
                        Test Results [Reg#<span id="testRegNumber"></span>]</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                    <div class="row">
                        <div class="col-md-3 small">
                            <a href="#">
                                <span class="bi bi-check-circle text-primary" id="bioChemIcon"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Biochemistry</span>
                            </a>
                        </div>
                        <div class="col-md-3 small">
                            <a href="#">
                                <span class="bi bi-check-circle text-primary" id="stoolIcon"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Stool</span>
                            </a>
                        </div>
                        <div class="col-md-3 small">
                            <a href="#">
                                <span class="bi bi-check-circle text-primary" id="bloodIcon"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Blood</span>
                            </a>
                        </div>
                        <div class="col-md-3 small">
                            <a href="#">
                                <span class="bi bi-check-circle text-primary" id="colonIcon"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Colonscopy</span>
                            </a>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-3 small">
                            <a href="#">
                                <span class="bi bi-check-circle text-primary" id="gastrosIcon"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Gastroscopy</span>
                            </a>
                        </div>
                        <div class="col-md-3 small">
                            <a href="#">
                                <span class="bi bi-check-circle text-primary" id="urineIcon"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Urine</span>
                            </a>
                        </div>
                        <div class="col-md-3 small">
                            <a href="#">
                                <span class="bi bi-check-circle text-primary" id="xrayIcon"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">X-Ray</span>
                            </a>
                        </div>
                        <div class="col-md-3 small">
                            <a href="#">
                                <span class="bi bi-check-circle text-primary" id="sonogIcon"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Sonography</span>
                            </a>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-3 small">
                            <a href="#">
                                <span class="bi bi-check-circle text-primary" id="ecgIcon"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">ECG</span>
                            </a>
                        </div>
                        <div class="col-md-3 small">
                            <a href="#" data-toggle="modal" data-target="#otherTestRequestModal" onclick="ShowOtherTest();GetOtherTestResult()">
                                <span class="bi bi-check-circle text-primary" id="otherIcon"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Other Tests</span>
                            </a>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="otherTestRequestModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-check-circle mr-2 text-success" style="font-size: 22px;"></span>
                        Other Results</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                    <div class="row mb-2">
                        <div class="col-md-12 small">
                            <a href="#" onclick="BackToHistory()">
                                <span class="bi bi-chevron-left"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1">Back</span>
                            </a>
                            <a href="#" onclick="BackToHistory()">
                                <span class="bi bi-images"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1">Image Result</span>
                            </a>
                            <a href="#" onclick="BackToHistory()">
                                <span class="bi bi-send-plus"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1">Email Result</span>
                            </a>
                            <a href="#" onclick="BackToHistory()">
                                <span class="bi bi-tv"></span>
                                <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1">See Result Standard</span>
                            </a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 small">
                            <div class="card border-left-danger">
                                <div id="otherTestResultDiv" style="overflow-x: scroll" class="mt-2 mx-2 text-gray-700">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="MedicineModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-pin mr-2" style="color: #c34dc1; font-size: 22px"></span>
                        Add Medicine</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Medicine Name"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Injection Name">Medicine Name</span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-12">
                            <asp:TextBox ID="txtMedicineName" placeholder="Medicine Name"
                                ClientIDMode="Static" class="form-control form-control-sm 
                                rounded-left rounded-right"
                                runat="server"></asp:TextBox>

                        </div>
                    </div>
                    <div class="row mb-2 border-bottom">
                        <div class="col-12 mb-2">
                            <span class="bi bi-pen text-gray-500 " data-toggle="tooltip" title="Dose and Notes"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Notes">Notes</span>
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-12">
                            <asp:TextBox ID="txtDosaAndNotes" Height="80px" placeholder="Dose and Notes" TextMode="MultiLine"
                                ClientIDMode="Static" class="form-control form-control-sm 
                                rounded-left rounded-right"
                                runat="server"></asp:TextBox>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">

                    <button class="btn  btn-sm text-white" type="button"
                        onclick="CreateMedicineSchedule()" style="border-radius: 7px; background-color: #ba99d4">
                        <span class="bi bi-plus mr-1"></span>Add
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="DiseaseModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-pin mr-2" style="color: #c34dc1; font-size: 22px"></span>
                        Add Disease</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Disease Name"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Disease Name">Disease Name</span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-12">
                            <asp:DropDownList ID="ddlDiseaseNamePositive" ClientIDMode="Static" runat="server" class="form-control form-control-sm 
                                rounded-left rounded-right">

                            </asp:DropDownList>

                        </div>
                    </div>
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Disease Name"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Disease Name">Disease Type</span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-12">
                            <asp:DropDownList ID="ddlDiseaseType" ClientIDMode="Static" runat="server" class="form-control form-control-sm 
                                rounded-left rounded-right">
                            </asp:DropDownList>

                        </div>
                    </div>
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Disease Name"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Disease Name">Disease Condtion</span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-12">
                            <asp:DropDownList ID="ddlDiseaseCondion" ClientIDMode="Static" runat="server" class="form-control form-control-sm 
                                rounded-left rounded-right">
                            </asp:DropDownList>

                        </div>
                    </div>
                    <div class="row mb-2 border-bottom">
                        <div class="col-12 mb-2">
                            <span class="bi bi-pen text-gray-500 " data-toggle="tooltip" title="Remarks"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Notes">Remarks</span>
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-12">
                            <asp:TextBox ID="txtDiseaseRemark" Height="80px" placeholder="Remarks" TextMode="MultiLine"
                                ClientIDMode="Static" class="form-control form-control-sm 
                                rounded-left rounded-right"
                                runat="server">
                            </asp:TextBox>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">

                    <button class="btn  btn-sm text-white" type="button"
                        onclick="SaveDiseasePositiveData()" style="border-radius: 7px; background-color: #ba99d4">
                        <span class="bi bi-plus mr-1"></span>Add
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="AppointmentModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-clock mr-2" style="color: #c34dc1; font-size: 22px"></span>
                        Add Apointment</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                    <div class="row mb-2 border-bottom">
                        <div class="col-12 mb-2">
                            <span class="bi bi-pen text-gray-500 " data-toggle="tooltip" title="Notes"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Notes">Notes</span>
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-12">
                            <asp:TextBox ID="txtNotes" Height="120px" placeholder="Notes" TextMode="MultiLine"
                                ClientIDMode="Static" class="form-control form-control-sm 
                                rounded-left rounded-right"
                                runat="server"></asp:TextBox>

                        </div>
                    </div>
                    <div class="row mb-2 border-bottom">
                        <div class="col-12 mb-2">
                            <span class="bi bi-calendar-event text-gray-500 " data-toggle="tooltip" title="Due Date"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Due Date">Due Date</span>
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-12">
                            <asp:TextBox ID="txtDueDate" TextMode="Date" placeholder="Patient Name" ClientIDMode="Static" data-toggle="tooltip" title="Due Date" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">

                    <button class="btn  btn-sm text-white" type="button"
                        onclick="CreateAppointment()" style="border-radius: 7px; background-color: #ba99d4">
                        <span class="bi bi-plus mr-1"></span>Add
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="InjectionModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-pass mr-2" style="color: #c34dc1; font-size: 22px"></span>
                        Add Injection Schedule</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Injection Name"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Injection Name">Injection Name</span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-12">
                            <asp:TextBox ID="txtInjectionName" placeholder="Injection Name"
                                ClientIDMode="Static" class="form-control form-control-sm 
                                rounded-left rounded-right"
                                runat="server"></asp:TextBox>

                        </div>
                    </div>
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-pen text-gray-500 " data-toggle="tooltip" title="Notes"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Notes">Notes</span>
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-12">
                            <asp:TextBox ID="txtInjectionNotes" Height="100px" placeholder="Notes" TextMode="MultiLine"
                                ClientIDMode="Static" class="form-control form-control-sm 
                                rounded-left rounded-right"
                                runat="server"></asp:TextBox>

                        </div>
                    </div>
                    <div class="row mb-2 border-bottom">
                        <div class="col-12 mb-2">
                            <span class="bi bi-calendar-event text-gray-500 " data-toggle="tooltip" title="Due Date"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Due Date">Due Date</span>
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-12">
                            <asp:TextBox ID="txtInjectionDueDate" TextMode="Date" placeholder="Patient Name" ClientIDMode="Static" data-toggle="tooltip" title="Due Date" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">

                    <button class="btn  btn-sm text-white" type="button"
                        onclick="CreateInjectionSchedule()" style="border-radius: 7px; background-color: #ba99d4">
                        <span class="bi bi-plus mr-1"></span>Add
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="SessionModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-dash-circle mr-2" style="color: #c34dc1; font-size: 22px; display: initial"></span>
                        End All Session</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Injection Name"></span>
                            <span class="small text-gray-700 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Injection Name">Are you sure you want to end all sessions ?</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">

                    <button class="btn  btn-sm text-white" type="button"
                        onclick="EndAllSession()" style="border-radius: 7px; background-color: #ba99d4">
                        <span class="bi bi-dash-circle mr-1"></span>End
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="AIModal" style="zoom:90%" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-boxes mr-2" style="color: #c34dc1; font-size: 22px"></span>
                        Examine Using AI</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Injection Name"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Injection Name">Symptoms</span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-12">
                            <input id="txtSymptoms" type="text" class="form-control form-control-sm 
                                rounded-left rounded-right"
                                placeholder="Type Symptoms" 
                                aria-label="Search"  aria-describedby="search-addon" />
                 
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-12">
                            <div id="tagDiv"></div>
                        </div>
                    </div>
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-pie-chart text-gray-500 " data-toggle="tooltip" title="Disease Distribution"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Disease Distribution">Disease Distribution</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-5 border-right">
                            <div class="" style="height: 150px; width: 150px">
                                <canvas id="diseaseBarChart"></canvas>
                            </div>
                        </div>
                        <div class="col-7 mt-4 text-left" id="diseaseDiv">
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" id="diseaseSpan"></span>
                                <span class="small text-danger" id="probSpan"></span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn  btn-sm text-white" type="button" onclick="predictDisease()"
                        style="border-radius: 7px; background-color: #ba99d4">
                        <span class="bi bi-disc mr-1"></span>Analyze
                    </button>
                    <button class="btn  btn-sm text-white" onclick="createTag()" type="button"
                        style="border-radius: 7px; background-color: #ba99d4">
                        <span class="bi bi-plus mr-1"></span>Add
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="FollUpModal" style="zoom:90%" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content" style="border-radius: 18px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-file-earmark-check mr-2" style="color: #c34dc1; font-size: 22px"></span>
                        Floow Up Patient</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                    <div class="row mb-3">
                        <div class="col-6">
                            <span class="bi bi-patch-check text-gray-500 mb-2" data-toggle="tooltip" title="Disease Name"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Disease Name">Disease Name</span>
                            <asp:DropDownList ID="ddlDiseaseNameFollowUp" ClientIDMode="Static" runat="server" class="form-control form-control-sm 
                                rounded-left rounded-right">

                            </asp:DropDownList>

                        </div>
                        <div class="col-6">
                            <span class="bi bi-patch-check text-gray-500 mb-2" data-toggle="tooltip" title="Disease Name"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Disease Name">Follow Up Type</span>
                            <asp:DropDownList ID="ddlFollowUpType" ClientIDMode="Static" runat="server" class="form-control form-control-sm 
                                rounded-left rounded-right">
                                <asp:ListItem>Short Term</asp:ListItem>
                                <asp:ListItem>Long Term</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Disease Name"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Disease Name">Treatment Type</span>
                            <a href="#" onclick="SaveFollowUpTreatmentType()">
                                <span class="bi bi-plus" data-toggle="tooltip" data-placement="top" title="Add Treatment Method for the selected disease"></span>
                                <span class="h5 text-primary text-uppercase font-weight-light badge badge-light mr-1">Add</span>
                            </a>
                        </div>
                    </div>
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <asp:DropDownList ID="ddlDiseaseTreatmentTypeFollowUp" ClientIDMode="Static" runat="server" class="form-control form-control-sm 
                                rounded-left rounded-right">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Disease Name"></span>
                            <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Disease Name">Expected Termination Period</span>
                        </div>
                    </div>
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                       <asp:TextBox ID="txtFollowUpPeriod" TextMode="Date" ClientIDMode="Static" runat="server" class="form-control form-control-sm"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn  btn-sm text-white" type="button"
                        onclick="SaveFollowUpDisease()" style="border-radius: 3px; background-color: #ba99d4">
                        <span class="bi bi-plus mr-1"></span>Add Disease
                    </button>
                    <button class="btn  btn-sm text-white" type="button"
                        onclick="SaveFollowUp()" style="border-radius: 3px; background-color: #ba99d4">
                        <span class="bi bi-save mr-1"></span>Save
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade " style="zoom:100%" id="XrayModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="border-radius: 10px">
                <div class="modal-header">
                    <h5 class="modal-title text-uppercase text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                        <span class="bi bi-robot mr-2 text-warning" style="font-size: 30px"></span>
                        ChestX [REG#<span id="regNumber"></span>]
                    </h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 465px; overflow-y: scroll">
                    <div class="row mb-2">
                        <div class="col-7">

                            <center>
                                <div class="img-magnifier-container">
                                    <img src="../lab/image-results/xray/normal/IM-0005-0001.jpeg" id="xrayImgSrc" alt="" />
                                </div>

                            </center>
                            <main role="main" id="xrayImageStatus">
                                <div class="starter-template">
                                    <center>
                                        <p class="lead">
                                        </p>

                                        <h6 class="text-gray-700 small">No Xray Image Uploaded!</h6>

                                    </center>
                                </div>
                            </main>
                            <br />
                            <br />
                            <br />
                            <center>
                                <span id="xrayImgPathSpan" class="badge badge-primary"></span>
                            </center>
                        </div>
                        <div class="col-7">
                        </div>
                    </div>
                </div>
                <div class="border-top mt-2 mb-1">
                    <center>
                        <span>
                            <button class="btn btn-sm  mt-1 btn-warning" data-toggle="modal" data-target="#imageUplaodModal" type="button" style="border-radius: 11px">
                                <span data-toggle="tooltip" title="Upload Xray Image" class="bi bi-upload text-white"></span>
                            </button>
                            <button class="btn btn-sm mt-1 btn-warning" data-toggle="modal" data-target="#" onclick="SaveAndAnalyzeXray()" type="button" style="border-radius: 11px">
                                <span data-toggle="tooltip" title="Proccess Images" class="bi bi-plugin text-white"></span>
                            </button>
                            <button class="btn btn-sm mt-1 btn-warning" data-toggle="modal" data-target="#RecieveCreditModal" onclick="GenerateHeatmap()" type="button" style="border-radius: 11px">
                                <span data-toggle="tooltip" title="Create AI Assisted Heatmaps" class="bi bi-robot text-white"></span>
                            </button>
                            <button class="btn btn-sm mt-1 btn-warning" data-toggle="modal" data-target="#RecieveCreditModal" onclick="GenerateHeatmap()" type="button" style="border-radius: 11px">
                                <span data-toggle="tooltip" title="Create AI Assisted Segmentation" class="bi bi-robot text-white"></span>
                            </button>
                            <button class="btn btn-sm  mt-1 btn-warning" data-toggle="modal" data-target="#RecieveCreditModal" onclick="GenerateHeatmap()" type="button" style="border-radius: 11px">
                                <span data-toggle="tooltip" title="Compare Top one predicted Heatmap" class="bi bi-robot text-white"></span>
                            </button>
                            <button class="btn btn-sm mt-1 btn-warning" data-toggle="modal" data-target="#RecieveCreditModal" onclick="GenerateHeatmap()" type="button" style="border-radius: 11px">
                                <span data-toggle="tooltip" title="Back to normal" class="bi bi-robot text-white"></span>
                            </button>
                        </span>
         
                    </center>
        
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade " style="zoom: 100%" id="MRIModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="border-radius: 10px">
                <div class="modal-header">
                    <h6 class="modal-title font-weight-bold text-gray-900">
                        <span class="bi bi-collection mr-2" style="color: #f2a768; font-size: 20px"></span>
                        MRI Analyzer: RegNo#0023</h6>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 465px; overflow-y: scroll; overflow-x: clip">
                    <div class="row">
                        <div class="col-7 border-right " style="margin-left: -15px; margin-top: -15px; margin-bottom: -15px; border-color: #c34dc1">
                            <center>
                                <img class="" src="../../assets/icons/feather/image.svg" id="mriImgSrc" />
                            </center>
                            <main role="main" id="mriImageStatus">

                                <div class="starter-template">
                                    <center>
                                        <p class="lead">
                                        </p>
                                        <span class="text-xs text-gray-500">*No MRI Image Uploaded!</span>
                                        <br />
                                        <a href="#" data-toggle="modal" data-target="#MRIImageUplaodModal">
                                            <span class="bi bi-upload"></span>
                                            <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Add Apointnment">upload</span>
                                        </a>
                                    </center>
                                </div>
                            </main>

                        </div>
                        <div class="col-5">
                            <span class="bi bi-pie-chart text-gray-500"></span>
                            <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Add Apointnment">AI Prediction Results</span>
                            <center>
                                <span id="mriImgPathSpan" class="badge badge-light"></span>
                            </center>
                            <div class="progress mt-3" style="height: 7px">
                                <div class="progress-bar bg-success" style="width: 30%" role="progressbar" id="requestPending" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                                <div class="progress-bar" style="background-color: #ba99d4; width: 50%" id="requestExamining" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                <div class="progress-bar" style="background-color: #5375b2; width: 20%" id="requestExamining" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                <div class="progress-bar" style="background-color: #f2a768; width: 20%" id="requestExamining" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                <br />
                            </div>
                            <div class="small mt-1">
                                <span class="small text-uppercase font-weight-light badge badge-light mr-3" style="color: #ff8b8b" data-toggle="tooltip" data-placement="top" title="Add Injection Schedule">Normal:30%</span>
                                <span class="small text-uppercase font-weight-light badge badge-light mr-3" style="color: #ba99d4" data-toggle="tooltip" data-placement="top" title="Add Injection Schedule">meningioma:50%</span>
                                <span data-toggle="modal" data-target="#KnowledgeGraphModal" class="small text-uppercase font-weight-light badge badge-light mr-1" style="color: #5375b2" data-toggle="tooltip" data-placement="top" title="Add Injection Schedule">glioma:20%</span>
                                <span class="small text-uppercase font-weight-light badge badge-light mr-1" style="color: #5375b2" data-toggle="tooltip" data-placement="top" title="Add Injection Schedule">pituitary:20%</span>
                            </div>
                            <br />
                            <div class="card-body border-left-warning">
                                <span class="text-xs text-gray-500" style="text-align:justify">The probabilistic distribution predicted by the ai indiactaed 80% chance to be glioma disease. To get more clear lesion identification you can segment the result.</span>
                            </div>
                            <main role="main" id="mriImageStatus" style="display: none">
                                <div class="starter-template">
                                    <center>
                                        <p class="lead">
                                        </p>
                                        <span class="bi bi-pie-chart text-gray-300 fa-6x mb-2"></span>
                                        <h6 class="text-gray-700 small">No Analysis Performed.</h6>

                                    </center>
                                </div>
                            </main>
                            <br />
                            <br />
                            <br />

                            <br />
                            <div class="row">
                                <div class="col-md-12 small">
                                    <center>
                                        <a href="#" style="color: #ba99d4" onclick="BackToHistory()">
                                            <span class="bi bi-plugin"></span>
                                            <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1">Analyze</span>
                                        </a>
                                        <a href="#" style="color: #ba99d4">
                                            <span class="bi bi-eye"></span>
                                            <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Add Apointnment">Segment</span>
                                        </a>
                                        <a href="#" style="color: #ba99d4">
                                            <span class="bi bi-filter-circle"></span>
                                            <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Add Injection Schedule">Normal</span>
                                        </a>
                                        <a href="#" style="color: #ba99d4">
                                            <span class="bi bi-record-circle"></span>
                                            <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" data-placement="top" title="Compare Segmentation">Compare</span>
                                        </a>
                                    </center>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <span class="text-xs text-gray-700">*If you notice performance issues on AI systems please notify the admin for improvement.</span>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade " id="KnowledgeGraphModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content" style="border-radius: 14px">
                <div class="modal-header">
                    <h4 style="color: #000000" class="font-weight-bold">Glioma</h4>

                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-12">
                            <nav class="small">
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                    <a class="nav-link active text-primary"  id="navH" data-toggle="tab" data-target="#nav-home" runat="server" aria-controls="nav-home" aria-selected="true">Overview
                                    </a>
                                    <a class="nav-link" id="navT" data-toggle="tab"  data-target="#nav-trans" runat="server" aria-controls="nav-profile" aria-selected="false">Symptoms</a>
                                    <a class="nav-link" id="navHI" data-toggle="tab"  data-target="#nav-history" runat="server" aria-controls="nav-contact" aria-selected="false">Treatment</a>
                                </div>
                            </nav>
                            <div class="tab-content" id="nav-tabContent">
                                <div class="tab-pane mt-3 fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                    <a href="#" onclick="BackToHistory()">
                                        <span class="bi bi-lightbulb"></span>
                                        <span class="h5 text-gray-500  font-weight-light badge badge-light mr-1">Description</span>
                                    </a>
                                    <br />
                                    <span class="text-xs text-gray-700 mb-2" style="text-align: justify">The probabilistic distribution predicted by the ai 
                                    indiactaed 80% chance to be glioma disease. 
                                    To get more clear lesion identification 
                                    you can segment the result. The probabilistic distribution predicted by the ai 
                                    indiactaed 80% chance to be glioma disease. 
                                    To get more clear lesion identification 
                                    you can segment the result. The probabilistic distribution predicted by the ai 
                                    indiactaed 80% chance to be glioma disease. 
                                    To get more clear lesion identification 
                                    you can segment the result.
                                    </span>
                                    <br />
                                    <br />
                                    <a href="#" onclick="BackToHistory()">
                                        <span class="bi bi-images"></span>
                                        <span class="h5 text-gray-500  font-weight-light badge badge-light mr-1">Images</span>
                                    </a>
                                    <div id="carousel-example-generic" class="carousel slide carousel-fade pl-2 pr-2" data-ride="carousel" data-ride="carousel">
                                        <!-- Indicators -->
                                        <div id="Repiv" runat="server">
                                            <ol class="carousel-indicators" id="prfdiv" runat="server">
                                                <li class="text-warning" data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                                <li data-target="#carousel-example-generic" data-slide-to="2"></li>

                                            </ol>

                                            <!-- Wrapper for slides -->

                                            <div class="carousel-inner" id="showdefaultimagefromdatabase" runat="server">
                                                <div>
                                                    <div class="carousel-item active">
                                                        <img src="../../assets/images/tumor/test4.jpg" class=" h-5 w-100"  />
                                                    </div>
                                                </div>

                                            </div>

                                            <!-- Controls -->
                                            <a class="carousel-control-prev text-gray-900" href="#carousel-example-generic" role="button" data-slide="prev">
                                                <span class="fas fa-arrow-left fa-1x btn-circle  border-left border-bottom border-right border-top" style="color: #ff00bb; border-color: #ff00bb;"></span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                            <a class="carousel-control-next" href="#carousel-example-generic" role="button" data-slide="next">
                                                <span class="fas fa-arrow-right fa-1x btn-circle  border-bottom border-right border-left border-top" style="color: #ff00bb; border-color: #ff00bb;"></span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade mt-3" id="nav-trans" role="tabpanel" aria-labelledby="nav-profile-tab">
                                    <a href="#" onclick="BackToHistory()">

                                        <span class="h5 mb-2 text-gray-500  font-weight-light badge badge-light mr-1">
                                            The main symptoms associated with glioma brain tumor
                                             are listed belows
                                        </span>
                                    </a>
                                    <br />
                                    <div class="small">
                                        <span class="bi bi-patch-check text-success"></span>
                                        <span class="small text-gray-500  mr-1">Sleep Sneezing</span>
                                        <br />
                                        <span class="bi bi-patch-check text-success"></span>
                                        <span class="small text-gray-500  mr-1">Vomiting</span>
                                        <br />
                                        <span class="bi bi-patch-check text-success"></span>
                                        <span class="small text-gray-500  mr-1">Main illness</span>
                                        <br />
                                        <span class="bi bi-patch-check text-success"></span>
                                        <span class="small text-gray-500  mr-1">Bintainsess neghh</span>
                                        <br />
                                        <span class="bi bi-patch-check text-success"></span>
                                        <span class="small text-gray-500  mr-1">All was fine</span>
                                        <br />
                                        <span class="bi bi-patch-check text-success"></span>
                                        <span class="small text-gray-500  mr-1">Additional Stars</span>
                                        <br />
                                        <span class="bi bi-patch-check text-success"></span>
                                        <span class="small text-gray-500  mr-1">Clinical advertizing</span>
                                        <br />
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="nav-history" role="tabpanel" aria-labelledby="nav-contact-tab">

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="modal fade " id="imageUplaodModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content" style="border-radius:14px">
                <div class="modal-header">
                    <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                        <span class="bi bi-image mr-2 text-gray-500" style="font-size: 20px;"></span>
                        Upload XRAY Image
                    </h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-12">
                            <center>
                                <input type="file" class="upload" id="f_UploadImage">
                            </center>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="modal fade " id="MRIImageUplaodModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content" style="border-radius: 14px">
                <div class="modal-header">
                    <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                        <span class="bi bi-image mr-2 text-gray-500" style="font-size: 20px;"></span>
                        Upload MRI Image
                    </h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-12">
                            <center>
                                <input type="file" class="upload" id="mriUloader">
                            </center>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="modal fade " id="LoaderModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
            <div class="modal-content" style="border-radius: 15px">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-12">
                            <center>
                                <div id="xrayLoader" class="mt-1">
                                    <span class="spinner-border spinner-border-sm text-danger"></span>
                                    <span class="small text-gray-900 mx-1">Proccessing Image...</span>
                                </div>
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/image-uploader.js"></script>
    <script>
        function Predict() {
            var datas = {
                model_type: "all",
                img_path: document.getElementById("xrayImgPathSpan").innerText
            }
            console.log(JSON.stringify(datas))
            $.ajax({
                type: "POST",
                url: 'http://localhost:5000/predict',
                data: JSON.stringify(datas),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    document.getElementById("xrayLoader").className = ""
                    alert("Pneumonia:"+response["Pneumonia"])
                },
                error: function (error) {
                    alert("Error during saving!");
                }
            });
        }
        function GenerateHeatmap() {
            var datas = {
                model_type: "all",
                img_path: document.getElementById("xrayImgPathSpan").innerText
            }
            $('#LoaderModal').modal('show')
            $.ajax({
                type: "POST",
                url: 'http://localhost:5000/heatmap',
                data: JSON.stringify(datas),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    let path = "../lab/image-results/xray/heatmap/" + response.path;

                    $("#xrayImgSrc").attr("src", path);
                    $('#LoaderModal').modal('hide')
                },
                error: function (error) {
                    alert("Error during connecting to the api server!");
                    $('#LoaderModal').modal('hide')
                }
            });
        }
    </script>
    <script src="js/dashboard-chart.js"></script>
    <script src="js/dashboard.js"></script>
    <script src="js/push.js"></script>
    <script src="js/patient-history.js"></script>
    <script src="js/autocomplete.js"></script>
    <script src="../../assets/select2/dist/js/select2.full.min.js"></script>
    <script src="../../assets/zoom/fancybox.umd.js"></script>
    <script src="js/diseasemodels.js"></script>

    <script>
        initSample();
    </script>
    <script>
        // Initiate zoom effect:
        magnify("xrayImgSrc", 3);
    </script>
</asp:Content>
