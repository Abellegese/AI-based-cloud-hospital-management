<%@ Page Title="" Language="C#" MasterPageFile="~/app/card/app.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="hms.ui.app.card.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Home</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid pl-3 pr-2" style="position: relative">

        <div class="row  " style="zoom:85%">
            <div class="col-xl-3   mb-2 mt-2">
                <div class="bg-white " style="border-radius: 25px">
                    <div class="card-header bg-white " style="border-radius: 19px">
                        <div class="row ">
                            <div class="col-12 text-left ">
                                <div class="text-xs font-weight-bolder text-primary  text-uppercase mb-1">
                                    Request <span class="text-gray-400 badge badge-light small">Current Session</span>
                                    <span id="Span21" runat="server" visible="false" class="mb-1 small font-italic text-danger"></span><span id="Span22" visible="false" class="mb-1 mr-2 ml-2 mb-1 small font-italic text-danger" runat="server">-</span><span id="Span23" visible="false" class="mb-1 small font-italic text-danger" runat="server"></span>
                                </div>
                            </div>

                        </div>

                    </div>

                    <div class="row ">

                        <div class="col-xl-12 mx-2 ">
                            <center>
                                <div class="chart-pie mt-3" style="height: 200px; width: 200px;">
                                    <canvas id="requestChart"></canvas>
                                    <span class="bi bi-check-circle text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                    <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Examining</span>
                                    <span class="font-weight-bold text-xs text-uppercase text-right  text-warning" id="Span13" runat="server">0</span>
                                    <span class="bi bi-check-circle text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                    <span class="small text-gray-500 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Examining</span>
                                    <span class="font-weight-bold text-xs text-uppercase text-right  text-warning" id="Span14" runat="server">0</span>
                                </div>
                            </center>
                        </div>

                    </div>

                </div>
            </div>
            <div class="col-xl-4 mb-2 mt-2  ">
                <div class="bg-white " style="border-radius: 25px;color:#808080">
                    <div class="card-header bg-white " style="border-radius: 19px">

                        <div class="row ">
                            <div class="col-12 text-left ">
                                <div class="text-xs font-weight-bolder text-primary  text-uppercase mb-1">
                                    Patient By Gender <span class="text-gray-400 badge badge-light small">Current Session</span>
                                    <span id="Span1" runat="server" visible="false" class="mb-1 small font-italic text-danger"></span><span id="Span2" visible="false" class="mb-1 mr-2 ml-2 mb-1 small font-italic text-danger" runat="server">-</span><span id="Span3" visible="false" class="mb-1 small font-italic text-danger" runat="server"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-xl-6 mx-1 ">
                            <center>
                                <div class="chart-pie mt-3" style="height: 200px; width: 200px;">
                                    <canvas id="genderChart" height="85%"></canvas>
                                </div>
                            </center>
                        </div>
                        <div class="col-xl-5">
                            <br />
                            <div class="row mt-5">
                                <div class="col-xl-6">
                                    <div class="card mt-3 small" style="border-radius: 15px; background-color: #ed8d6240;">
                                        <div class="card-body">

                                            <span class="bi bi-person-circle  btn-sm bg-white fa-2x" style="border-radius: 7px; color: #c34dc150"></span>
                                            <br />
                                            <br />

                                            <span class="text-gray-700 font-weight-bold font-weight-light small">Male</span>
                                            <br />
                                            <span class="text-gray-600  mb-3 h6 mt-3 font-weight-bolder" id="requestCount">0</span>

                                        </div>
                                    </div>

                                </div>
                                <div class="col-xl-6">
                                    <div class="card mt-3 small" style="border-radius: 15px; background-color: #89c33540;">
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
                            </div>
                            
                         
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-5 mb-2 mt-2  ">
                <div class="bg-white " style="border-radius: 25px">
                    <div class="card-header bg-white " style="border-radius: 19px">

                        <div class="row ">
                            <div class="col-12 text-left ">
                                <div class="text-xs font-weight-bolder text-primary  text-uppercase mb-1">
                                    Patient By Age <span class="text-gray-400 badge badge-light small">Current Session</span>
                                    <span id="Span4" runat="server" visible="false" class="mb-1 small font-italic text-danger"></span><span id="Span5" visible="false" class="mb-1 mr-2 ml-2 mb-1 small font-italic text-danger" runat="server">-</span><span id="Span6" visible="false" class="mb-1 small font-italic text-danger" runat="server"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row ">
                        <div class="col-xl-5 ">
                            <div class="chart-pie mt-3 mx-4" style="height: 200px; width: 200px;">
                                <canvas id="appointmentChart" height="85%"></canvas>
                            </div>
                        </div>
                        <div class="col-xl-6">
                            <div class="row">
                                <div class="col-xl-6">
                                    <div class="card mt-3 small" style="border-radius: 15px; background-color: #80808040;">
                                        <div class="card-body">

                                            <span class="bi bi-patch-check   btn-sm bg-white fa-2x" style="border-radius: 7px; color: #c34dc1"></span>
                                            <span class="text-gray-700 font-weight-bold font-weight-light small">OnGoing</span>
                                            <br />
                                            <br />
                                            <span class="text-gray-600  mb-3 h6 mt-3 font-weight-bolder" id="requestCount">0</span>
                                            <br />
                                            <a data-toggle="modal" class="mt-2" href="#" onclick="GetRequestDetails()" data-target="#RequestModal">
                                                <span class="text-primary text-xs mt-3 font-weight-bold">See
                                                <span class="bi bi-arrow-right"></span>

                                                </span>

                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-6">
                                    <div class="card mt-3 small" style="border-radius: 15px; background-color: #56829310;">
                                        <div class="card-body">

                                            <span class="bi  bi-dash-circle  btn-sm bg-white fa-2x" style="border-radius: 7px; color: #c34dc1"></span>
                                            <span class="text-gray-700 font-weight-bold font-weight-light small">Due Passed</span>
                                            <br />
                                            <br />
                                            <span class="text-gray-600  mb-3 h6 mt-3 font-weight-bolder" id="requestCount">0</span>
                                            <br />
                                            <a data-toggle="modal" class="mt-2" href="#" onclick="GetRequestDetails()" data-target="#RequestModal">
                                                <span class="text-primary text-xs mt-3 font-weight-bold">See
                                                <span class="bi bi-arrow-right"></span>

                                                </span>

                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-xl-6">
                                    <div class="card mt-3 small" style="border-radius: 15px; background-color: #56829310;">
                                        <div class="card-body">

                                            <span class="bi bi-patch-check   btn-sm bg-white fa-2x" style="border-radius: 7px; color: #56829377"></span>
                                            <span class="text-gray-700 font-weight-bold font-weight-light small">OnGoing</span>
                                            <br />
                                            <br />
                                            <span class="text-gray-600  mb-3 h6 mt-3 font-weight-bolder" id="requestCount">0</span>
                                            <br />
                                            <a data-toggle="modal" class="mt-2" href="#" onclick="GetRequestDetails()" data-target="#RequestModal">
                                                <span class="text-primary text-xs mt-3 font-weight-bold">See
                                                <span class="bi bi-arrow-right"></span>

                                                </span>

                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-6">
                                    <div class="card mt-3 small" style="border-radius: 15px; background-color: #56829310;">
                                        <div class="card-body">

                                            <span class="bi bi-patch-check   btn-sm bg-white fa-2x" style="border-radius: 7px; color: #56829377"></span>
                                            <span class="text-gray-700 font-weight-bold font-weight-light small">OnGoing</span>
                                            <br />
                                            <br />
                                            <span class="text-gray-600  mb-3 h6 mt-3 font-weight-bolder" id="requestCount">0</span>
                                            <br />
                                            <a data-toggle="modal" class="mt-2" href="#" onclick="GetRequestDetails()" data-target="#RequestModal">
                                                <span class="text-primary text-xs mt-3 font-weight-bold">See
                                                <span class="bi bi-arrow-right"></span>

                                                </span>

                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="row  ">
            <div class="col-xl-8 mb-2 mt-2  ">
                <div class="bg-white " style="border-radius: 25px">
                    <div class="card-header bg-white " style="border-radius: 19px">

                        <div class="row ">
                            <div class="col-12 text-left ">
                                <div class="text-xs font-weight-bolder text-primary  text-uppercase mb-1">
                                    Patient By Age <span class="text-gray-400 badge badge-light small">Current Session</span>
                                    <span id="Span7" runat="server" visible="false" class="mb-1 small font-italic text-danger"></span><span id="Span8" visible="false" class="mb-1 mr-2 ml-2 mb-1 small font-italic text-danger" runat="server">-</span><span id="Span9" visible="false" class="mb-1 small font-italic text-danger" runat="server"></span>
                                </div>
                            </div>
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
                    <div class="card-header bg-white " style="border-radius: 19px">

                        <div class="row ">
                            <div class="col-12 text-left ">
                                <div class="text-xs font-weight-bolder text-primary  text-uppercase mb-1">
                                    Patient By Age <span class="text-gray-400 badge badge-light small">Current Session</span>
                                    <span id="Span10" runat="server" visible="false" class="mb-1 small font-italic text-danger"></span><span id="Span11" visible="false" class="mb-1 mr-2 ml-2 mb-1 small font-italic text-danger" runat="server">-</span><span id="Span12" visible="false" class="mb-1 small font-italic text-danger" runat="server"></span>
                                </div>
                            </div>
                        </div>
                    </div>
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
                                <a href="#">
                                    <span class="bi bi-bag-plus text-gray-500" id="otherIcon"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Other Tests</span>
                                </a>
                            </div>

                        </div>
                        <hr />
                        <div class="row mt-3">
                            <div class="col-md-6 small">
                                <a href="#">
                                    <span class="bi bi-bookmarks text-gray-500"></span>
                                    <span class="h5 text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" title="Medicine Recommender">Remarks</span>
                                    <br />
                                </a>
                                <div id="remarks" class="small text-gray-600"></div>


                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
        <script src="js/dashboard-chart.js"></script>
        <script src="js/dashboard.js"></script>

    </div>
</asp:Content>
