<%@ Page Title="" Language="C#" MasterPageFile="~/app/lab/app.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="hms.ui.app.lab.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Dashboard</title>
    <style>
        #chat3 .form-control {
            border-color: transparent;
        }

            #chat3 .form-control:focus {
                border-color: transparent;
                box-shadow: inset 0px 0px 0px 1px transparent;
            }

        .badge-dot {
            border-radius: 50%;
            height: 10px;
            width: 10px;
            margin-left: 2.9rem;
            margin-top: -.75rem;
        }
    </style>
    <script src="../../assets/ckeditor/ckeditor.js"></script>
    <link href="../../assets/ckeditor/toolbarconfigurator/lib/codemirror/neo.css" rel="stylesheet" />
    <script src="../../assets/ckeditor/samples/js/sample.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid pl-3 pr-2" style="position: relative">

        <div class="row  ">
            <div class="col-xl-4 mb-2 mt-2  ">
                <div class="bg-white " style="border-radius: 25px">
                    <div class="row ">
                        <div class="col-12 text-left ">
                            <h6 class="font-weight-bold text-gray-900 mx-3 text-uppercase mt-3">
                                <span class="bi bi-stickies mr-2 text-gray-600" style="font-size: 15px"></span>
                                Diagnosis 
                            </h6>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-xl-12 mx-2">
                            <canvas id="dignosisChart" height="85%"></canvas>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2 border-top mb-1">
                                <div class="text-xs font-weight-bolder text-primary text-uppercase mb-2">Request</div>
                                <div class="row align-content-center">
                                    <div class="col-8">
                                        <div class="h6 mb-0 font-weight-bold text-gray-900">
                                            <a href="#" data-toggle="modal" onclick="GetRequestDetails()" data-target="#RequestModal" class="text-gray-800">
                                                <span id="requestCount" runat="server">0</span>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-1 text-left">
                                        <a class="dropdown-toggle btn-sm text-warning font-weight-bolder"href="#" role="button" id="dropdownReceivable" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                        <div class="dropdown-menu  dropdown-menu-left shadow animated--fade-in" style="width: 400px" aria-labelledby="dropdownReceivable">
                                            <center>
                                                <a class="dropdown-item text-primary" style="font-style: normal" href="#"><span>Aged Receivable Summary</span></a>
                                            </center>
                                            <div class="dropdown-divider"></div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED 1-30 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="receivableAgedOne" runat="server">0.00</span></div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED 31-60 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="receivableAgedTwo" runat="server">0.00</span></div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED  61-90 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="receivableAgedThree" runat="server">0.00</span></div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED  > 90 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="receivableAgedFour" runat="server">0.00</span></div>
                                            </div>
                                            <center>
                                                <a class="dropdown-item text-primary" href="creditnote.aspx"><i class="invisible"></i>See Report <span class="fas fa-arrow-right ml-2 text-primary"></span></a>

                                                <div class="dropdown-divider"></div>
                                                <a class="dropdown-item text-primary" href="#" data-toggle="modal" data-target="#ModalReceivableAnalysis"><i class="invisible"></i>See Analytics <span class="fas fa-arrow-right ml-2 text-primary"></span></a>

                                            </center>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="bi bi-send-check text-gray-500" style="font-size: 17px"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-4 mb-2 mt-2  ">
                <div class="bg-white " style="border-radius: 25px">
                    <div class="row ">
                        <div class="col-6 text-left ">
                            <h6 class="font-weight-bold text-gray-900 mx-3 text-uppercase mt-3">
                                <span class="bi bi-speedometer2 mr-2 text-gray-600" style="font-size: 15px"></span>
                                CASES 
                            </h6>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-xl-12 mx-2">
                            <canvas id="dignosisChart" height="85%"></canvas>
                        </div>

                    </div>
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2 border-top mb-1">
                                <div class="text-xs font-weight-bolder text-primary text-uppercase mb-2">Request</div>
                                <div class="row align-content-center">
                                    <div class="col-8">
                                        <div class="h6 mb-0 font-weight-bold text-gray-900"><a href="#" data-toggle="modal" data-target="#RequestModal" class="text-gray-800"><span id="Span1" runat="server">0</span></a></div>
                                    </div>
                                    <div class="col-1 text-left">
                                        <a class="dropdown-toggle btn-sm text-warning font-weight-bolder" onclick="BindReceivables()" href="#" role="button" id="dropdownReceivable" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                        <div class="dropdown-menu  dropdown-menu-left shadow animated--fade-in" style="width: 400px" aria-labelledby="dropdownReceivable">
                                            <center>
                                                <a class="dropdown-item text-primary" style="font-style: normal" href="#"><span>Aged Receivable Summary</span></a>
                                            </center>
                                            <div class="dropdown-divider"></div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED 1-30 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="Span2" runat="server">0.00</span></div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED 31-60 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="Span3" runat="server">0.00</span></div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED  61-90 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="Span4" runat="server">0.00</span></div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED  > 90 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="Span5" runat="server">0.00</span></div>
                                            </div>
                                            <center>
                                                <a class="dropdown-item text-primary" href="creditnote.aspx"><i class="invisible"></i>See Report <span class="fas fa-arrow-right ml-2 text-primary"></span></a>

                                                <div class="dropdown-divider"></div>
                                                <a class="dropdown-item text-primary" href="#" data-toggle="modal" data-target="#ModalReceivableAnalysis"><i class="invisible"></i>See Analytics <span class="fas fa-arrow-right ml-2 text-primary"></span></a>

                                            </center>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="bi bi-person-gear text-gray-500" style="font-size: 17px"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-4 mb-2 mt-2  ">
                <div class="bg-white " style="border-radius: 25px">
                    <div class="row ">
                        <div class="col-6 text-left ">
                            <h6 class="font-weight-bold text-gray-900 mx-3 text-uppercase mt-3">
                                <span class="bi bi-ui-radios-grid mr-2 text-gray-600" style="font-size: 15px"></span>
                                DISEASE 
                            </h6>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-xl-12 mx-2">
                            <canvas id="dignosisChart" height="85%"></canvas>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2 border-top mb-1">
                                <div class="text-xs font-weight-bolder text-primary text-uppercase mb-2">Request</div>
                                <div class="row align-content-center">
                                    <div class="col-8">
                                        <div class="h6 mb-0 font-weight-bold text-gray-900"><a href="#" data-toggle="modal"  data-target="#RequestModal" class="text-gray-800"><span id="Span6" runat="server">0</span></a></div>
                                    </div>
                                    <div class="col-1 text-left">
                                        <a class="dropdown-toggle btn-sm text-warning font-weight-bolder" onclick="BindReceivables()" href="#" role="button" id="dropdownReceivable" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                        <div class="dropdown-menu  dropdown-menu-left shadow animated--fade-in" style="width: 400px" aria-labelledby="dropdownReceivable">
                                            <center>
                                                <a class="dropdown-item text-primary" style="font-style: normal" href="#"><span>Aged Receivable Summary</span></a>
                                            </center>
                                            <div class="dropdown-divider"></div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED 1-30 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="Span7" runat="server">0.00</span></div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED 31-60 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="Span8" runat="server">0.00</span></div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED  61-90 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="Span9" runat="server">0.00</span></div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">AGED  > 90 DAYS</span></div>
                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="Span10" runat="server">0.00</span></div>
                                            </div>
                                            <center>
                                                <a class="dropdown-item text-primary" href="creditnote.aspx"><i class="invisible"></i>See Report <span class="fas fa-arrow-right ml-2 text-primary"></span></a>

                                                <div class="dropdown-divider"></div>
                                                <a class="dropdown-item text-primary" href="#" data-toggle="modal" data-target="#ModalReceivableAnalysis"><i class="invisible"></i>See Analytics <span class="fas fa-arrow-right ml-2 text-primary"></span></a>

                                            </center>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="bi bi-layout-wtf text-gray-500" style="font-size: 17px"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row  ">
            <div class="col-xl-8 mb-2 mt-2  ">
                <div class="bg-white " style="border-radius: 25px">
                    <div class="row ">
                        <div class="col-12 text-left ">
                            <h6 class="font-weight-bold text-gray-900 mx-3 text-uppercase mt-3">
                                <span class="bi bi-bar-chart mr-2 text-gray-600" style="font-size: 15px"></span>
                                patient visit 
                            </h6>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-xl-12 mx-2">
                            <canvas id="dignosisChart" height="85%"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-4 mb-2 mt-2  ">
                <div class="bg-white " style="border-radius: 25px">
                    <div class="row ">
                        <div class="col-6 text-left ">
                            <h6 class="font-weight-bold text-gray-900 mx-4 text-uppercase mt-2">RENT 
                            </h6>
                        </div>
                    </div>
                    <div class="border-top"></div>

                    <div class="row ">
                        <div class="col-xl-12 mx-2">
                            <canvas id="dignosisChart" height="85%"></canvas>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
        <div class="modal fade" id="RequestModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" style="border-radius: 18px">
                    <div class="modal-header">
                        <h6 class="modal-title font-weight-bold text-gray-900">
                            <span class="bi bi-send-check mr-2" style="font-size: 18px; color: #ef2d7a"></span>
                            Requests</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                        <div class="row">
                            <div class="col-md-12 small">
                                <table class="table align-items-center table-hover table-sm " id="requestTable">
                                </table>
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
                            <span class="bi bi-bag-plus mr-2" style="font-size: 22px; color: #ef2d7a"></span>
                            Test Requests[Reg<span class="bi bi-hash"></span><span id="testRegNumber"></span>]</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                        <div class="row">
                            <div class="col-md-3 small">
                                <a href="#">
                                    <span class="bi bi-bag-plus text-gray-500" id="bioChemIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Biochemistry</span>
                                </a>
                            </div>
                            <div class="col-md-3 small">
                                <a href="#">
                                    <span class="bi bi-bag-plus text-gray-500" id="stoolIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Stool</span>
                                </a>
                            </div>
                            <div class="col-md-3 small">
                                <a href="#">
                                    <span class="bi bi-bag-plus text-gray-500" id="bloodIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Blood</span>
                                </a>
                            </div>
                            <div class="col-md-3 small">
                                <a href="#">
                                    <span class="bi bi-bag-plus text-gray-500" id="colonIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Colonscopy</span>
                                </a>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-3 small">
                                <a href="#">
                                    <span class="bi bi-bag-plus text-gray-500" id="gastrosIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Gastroscopy</span>
                                </a>
                            </div>
                            <div class="col-md-3 small">
                                <a href="#">
                                    <span class="bi bi-bag-plus text-gray-500" id="urineIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Urine</span>
                                </a>
                            </div>
                            <div class="col-md-3 small">
                                <a href="#">
                                    <span class="bi bi-bag-plus text-gray-500" id="xrayIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">X-Ray</span>
                                </a>
                            </div>
                            <div class="col-md-3 small">
                                <a href="#">
                                    <span class="bi bi-bag-plus text-gray-500" id="sonogIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Sonography</span>
                                </a>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-3 small">
                                <a href="#">
                                    <span class="bi bi-bag-plus text-gray-500" id="ecgIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">ECG</span>
                                </a>
                            </div>
                            <div class="col-md-3 small">
                                <a href="#" data-toggle="modal" data-target="#OtherTestModal" onclick="ShowOtherTest()">
                                    <span class="bi bi-bag-plus text-gray-500" id="otherIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Other Tests</span>
                                </a>
                            </div>

                        </div>
                        <hr />
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <a href="#">
                                    <span class="bi bi-bookmarks text-gray-500"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Remarks</span>
                                    <br />
                                </a>
                                <div class="card border-left-danger">
                                    <div id="remarks" class="small mx-2 mt-2 text-gray-900"></div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                   
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="OtherTestModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" style="border-radius: 18px">
                    <div class="modal-header">
                        <h6 class="modal-title font-weight-bold text-gray-900">
                            <span class="bi bi-pie-chart mr-2" style="font-size: 22px; color: #ef2d7a"></span>
                            Other Tests [Reg#<span id="otherTestRegNumber"></span>]
                        <span id="opd" class="badge badge-light text-gray-400 mx-2"></span></h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                        <div class="row">
                            <div class="col-md-12 small">
                                <a href="#">
                                    <span class="bi bi-link"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1">Attach Image</span>
                                </a>
         
                                <br />
                                <br />
                                <textarea name="editorOtherTest" id="editorOtherTest"></textarea>
                                <script>
                                    CKEDITOR.replace('editorOtherTest');
                                </script>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-light btn-sm text-primary" type="button" onclick="SendTestResult()" style="border-radius: 14px">
                            <span class="bi bi-send-check mr-2"></span>Send Result
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/dashboard.js"></script>
</asp:Content>
