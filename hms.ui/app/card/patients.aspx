<%@ Page Title="" Language="C#" MasterPageFile="~/app/card/app.Master" AutoEventWireup="true" CodeBehind="patients.aspx.cs" Inherits="hms.ui.app.card.patients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Patients</title>

    <link href="../../assets/js/jquery-ui.xcss" rel="stylesheet" />
    <script src="../../assets/js/jquery-ui.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid pl-3 pr-3" style="position: absolute;" id="container" runat="server">
        <div id="snackbar">
            <img class="mr-2" src="../../assets/icons/feather/bell.svg" />
            Request Successfully Sent!! 
        </div>
        <div class="row">
            <div class="col">
                <div class="bg-white h-100" style="border-radius: 20px">
                    <div class="card-header bg-white " style="border-radius: 20px">
                        <div class="row">
                            <div
                                class="col-md-4 text-left">
                                <a class="btn btn-circle text-white btn-light mr-2" id="buttonback" href="creditnotes.aspx" visible="false" runat="server" data-toggle="tooltip" data-placement="bottom" title="Back to Credit">
                                    <span class="fa fa-arrow-left text-gray-600"></span>
                                </a>
                                <span class="badge mr-2 text-white badge-light text-gray-600 font-weight-bold" visible="false" id="creditDetailSpan" runat="server"></span>
                                <span class="badge mr-2 text-white text-white font-weight-bold" visible="false" id="creditStatusSpan" runat="server"></span>
                                <span class="bi bi-archive mr-2" style="color: #d46fe8;" runat="server"></span>
                                <span id="creditsSpan" class="small text-gray-900 font-weight-bold text-uppercase" runat="server">patients</span>
                            </div>
                            <div class="col-md-8 text-right">

                                <button class="btn btn-sm  mr-1 mt-1 btn-light" data-toggle="modal" data-target="#AddPatientModal" type="button" style="border-radius: 7px"><span class="bi bi-bookmark-check text-gray-500"></span></button>
                                <button class="btn btn-sm  mr-2 mt-1 btn-light" data-toggle="modal" data-target="#FilterModal" type="button" style="border-radius: 7px"><span class="fas fa-filter text-gray-500"></span></button>
                            </div>
                        </div>
                    </div>

                    <div class="card-body small text-gray-900" style="margin-top: -21px; border-radius: 15px" id="creditDiv" runat="server">
                        <asp:Repeater ID="rptrPatient" runat="server">
                            <HeaderTemplate>
                                <table class="table align-items-center table-hover table-sm " id="patientTable">
                                    <thead>
                                        <tr>
                                            <th scope="col" class="text-gray-500 font-weight-light   text-uppercase text-left">Date</th>
                                            <th scope="col" class="text-warning  font-weight-light   text-uppercase ">Reg No</th>
                                            <th scope="col" class="text-warning  font-weight-light   text-uppercase ">Name</th>
                                            <th scope="col" class="text-gray-500 font-weight-light   text-uppercase ">Address </th>
                                            <th scope="col" class="text-gray-500 font-weight-light   text-uppercase ">Contact</th>
                                            <th scope="col" class="text-gray-500 font-weight-light  text-uppercase ">Age</th>
                                            <th scope="col" class="text-gray-500 font-weight-light   text-uppercase  text-right">Gender</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr onclick="GetRowIndex(this)">

                                    <td class="text-gray-900 text-left">
                                        <span class="bi bi-calendar text-gray-300 " data-toggle="tooltip" title="Type"></span>
                                        <span class="small text-gray-500 font-weight-light badge badge-light mr-1">
                                            <%# Eval("RegDate", "{0: dd MMM yyyy}")%>
                                        </span>
                                    </td>
                                    <td class="text-primary">
                                        <%# Eval("RegNo")%>
                                    </td>
                                    <td class="text-gray-900">
                                        <%# Eval("Name")%>
                                    </td>
                                    <td class="text-gray-900">
                                        <%# Eval("Address")%>
                                    </td>

                                    <td class="text-gray-900">
                                        <%# Eval("Contact")%>
                                    </td>
                                    <td class="text-gray-900">
                                        <%# Eval("Age")%>
                                    </td>
                                    <td class="text-gray-900 text-right">
                                        <%# Eval("Gender")%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                  </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="FilterModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content" style="border-radius: 15px">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="bi bi-filter mr-2" style="color: #ff00bb; font-size: 23px"></span>
                            <span class="align-items-center">Filter Record </span>

                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-2 border-bottom">
                            <div class="col-12 mb-2">
                                <span class="bi bi-calendar text-gray-300 " data-toggle="tooltip" title="Date Range"></span>
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Date Range</span>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-12">
                                <div class="input-group">
                                    <asp:TextBox ID="txtSearch" AutoComplete="on" ClientIDMode="Static" class=" form-control form-control-sm" type="search" aria-label="Search" runat="server" placeholder="Search patients" aria-describedby="search-addon">

                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" onclick="SearchVal()" class="btn btn-sm mx-2 mr-2 btn-danger" style="border-radius: 8px">
                            <span class="fas fa-sync mr-2"></span>Fetch
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="AddPatientModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content" style="border-radius: 15px">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="bi bi-plus-circle-dotted mr-2" style="color: #ff00bb; font-size: 19px"></span>
                            <span class="align-items-center text-uppercase">Create Patient </span>

                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-2 border-bottom">
                            <div class="col-12 mb-2">
                                <span class="bi bi-info-circle text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Basic Info</span>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-6">
                                <asp:TextBox ID="txtRegNumber" placeholder="Regisiteration Number" ClientIDMode="Static" data-toggle="tooltip" title="From Date" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-6">
                                <asp:TextBox ID="txtRegDate" placeholder="Regisiteration Date" ClientIDMode="Static" TextMode="Date" data-toggle="tooltip" title="To Date" class="form-control form-control-sm  rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-12">
                                <asp:TextBox ID="txtName" placeholder="Patient Name" ClientIDMode="Static" data-toggle="tooltip" title="Patient Name" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-2 border-bottom">
                            <div class="col-12 mb-2">
                                <span class="bi bi-buildings text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Address</span>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-6">
                                <asp:TextBox ID="txtAddress" placeholder="Address" ClientIDMode="Static" data-toggle="tooltip" title="Address" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-6">
                                <asp:TextBox ID="txtCity" ClientIDMode="Static" placeholder="City" data-toggle="tooltip" title="City" class="form-control form-control-sm  rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-6">
                                <asp:TextBox ID="txtContact" ClientIDMode="Static" placeholder="Mobile" data-toggle="tooltip" title="Contact" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-6">
                                <asp:TextBox ID="txtEmail" ClientIDMode="Static" placeholder="Email" data-toggle="tooltip" title="Email" class="form-control form-control-sm  rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-2 border-bottom">
                            <div class="col-12 mb-2">
                                <span class="bi bi-calendar2-heart text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Status</span>
                            </div>
                        </div>
                        <div class="row mb-1 mt-2">
                            <div class="col-6">
                                <asp:DropDownList ID="ddlMaritalStatus" ClientIDMode="Static" class="form-control form-control-sm rounded-left rounded-right" runat="server">
                                    <asp:ListItem>-Select Status-</asp:ListItem>
                                    <asp:ListItem>Married</asp:ListItem>
                                    <asp:ListItem>UnMarried</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-6">
                                <asp:DropDownList ID="ddlReligion" ClientIDMode="Static" class="form-control form-control-sm rounded-left rounded-right" runat="server">
                                    <asp:ListItem>-Select Religion-</asp:ListItem>
                                    <asp:ListItem>Muslim</asp:ListItem>
                                    <asp:ListItem>Orthodox</asp:ListItem>
                                    <asp:ListItem>Protestant</asp:ListItem>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row mb-1 mt-2">
                            <div class="col-12">
                                <asp:DropDownList ID="ddlGender" ClientIDMode="Static" class="form-control form-control-sm rounded-left rounded-right" runat="server">
                                    <asp:ListItem>-Select Gender-</asp:ListItem>
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                        </div>
                        <div class="row mb-1">
                            <div class="col-6">
                                <asp:TextBox ID="txtBirthDate" TextMode="Date" ClientIDMode="Static" data-toggle="tooltip" title="Birth Date" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-6">
                                <asp:TextBox ID="txtAge" placeholder="Age" ClientIDMode="Static" TextMode="Date" data-toggle="tooltip" title="Age" class="form-control form-control-sm  rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-12">
                                <div class="custom-control mr-2 custom-checkbox custom-control-inline">
                                    <input type="checkbox" id="request" checked name="customRadioInline2" class="custom-control-input" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label text-gray-700 small " for="request">Send Request</label>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-2 border-bottom">
                            <div class="col-12 mb-2">
                                <span class="bi bi-back text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Rooms</span>
                            </div>
                        </div>
                        <div class="row mb-1 mt-2">
                            <div class="col-12">
                                <asp:DropDownList ID="ddlRooms" ClientIDMode="Static" class="form-control form-control-sm rounded-left rounded-right" runat="server">

                                </asp:DropDownList>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">

                        <asp:LinkButton ID="btnCreatePatient" OnClick="btnCreatePatient_Click" OnClientClick="ShowLoader()" class="btn btn-sm mx-2 mr-2 btn-danger" Style="border-radius: 8px" runat="server">
                            <span class="bi bi-send-check mr-2"></span>Save

                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="EditPatientModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content" style="border-radius: 15px">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="bi bi-pencil mr-2" style="color: #ff00bb; font-size: 19px"></span>
                            <span class="align-items-center">Edit Patient </span>

                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-2 border-bottom">
                            <div class="col-12 mb-2">
                                <span class="bi bi-info-circle text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Basic Info</span>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-12">
                                <asp:TextBox ID="txtEditPatientName" placeholder="Patient Name" ClientIDMode="Static" data-toggle="tooltip" title="Patient Name" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-2 border-bottom">
                            <div class="col-12 mb-2">
                                <span class="bi bi-buildings text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Address</span>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-6">
                                <asp:TextBox ID="txtEditAdddress" placeholder="Address" ClientIDMode="Static" data-toggle="tooltip" title="Address" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-6">
                                <asp:TextBox ID="txtEditCity" ClientIDMode="Static" placeholder="City" data-toggle="tooltip" title="City" class="form-control form-control-sm  rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-6">
                                <asp:TextBox ID="txtEditMobile" ClientIDMode="Static" placeholder="Mobile" data-toggle="tooltip" title="Contact" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-6">
                                <asp:TextBox ID="txtEditEmail" ClientIDMode="Static" placeholder="Email" data-toggle="tooltip" title="Email" class="form-control form-control-sm  rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-2 border-bottom">
                            <div class="col-12 mb-2">
                                <span class="bi bi-calendar2-heart text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Date Range">Status</span>
                            </div>
                        </div>
                        <div class="row mb-1 mt-2">
                            <div class="col-6">
                                <asp:DropDownList ID="ddlEditMaritalStatus" ClientIDMode="Static" class="form-control form-control-sm rounded-left rounded-right" runat="server">
                                    <asp:ListItem>-Select Status-</asp:ListItem>
                                    <asp:ListItem>Married</asp:ListItem>
                                    <asp:ListItem>UnMarried</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-6">
                                <asp:DropDownList ID="ddlEditReligion" ClientIDMode="Static" class="form-control form-control-sm rounded-left rounded-right" runat="server">
                                    <asp:ListItem>-Select Religion-</asp:ListItem>
                                    <asp:ListItem>Muslim</asp:ListItem>
                                    <asp:ListItem>Orthodox</asp:ListItem>
                                    <asp:ListItem>Protestant</asp:ListItem>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-sm mx-2 mr-2 btn-danger" onclick="UpdatePatient()" style="border-radius: 8px">
                            <span class="bi bi-save2 mr-2"></span>Save
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="PatientHistoryModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="CreditModalG" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
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
                                <div class="table-responsive">
                                    <table class="table align-items-center table-responsive table-hover table-sm table-bordered" style="zoom: 65%" id="historyTable">
                                    </table>
                                </div>
                                
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
        <div class="modal fade " id="patientDetailModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content" style="border-radius: 19px">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="bi bi-question-circle mr-2" style="color: #ff00bb; font-size: 20px"></span>
                            Patient Details [REG#<span id="regNumber"></span>]
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body" style="max-height: 400px; overflow-y: scroll">
                        <div class="row mb-2 ">
                            <div class="col-12 mb-2 ">
                                <div class="row border-bottom mb-2">
                                    <div class="col-12 mb-2">
                                        <span class="bi bi-info-circle text-gray-500 " data-toggle="tooltip" title="Basic Info"></span>
                                        <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Disease Statistics">Basic Info</span>
                                    </div>
                                </div>
                                <div class="row mb-2 border-bottom">
                                    <div class="col-6 mb-2">
                                        <span class="bi bi-at text-gray-300 " data-toggle="tooltip" title="Name"></span>
                                        <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Name" id="name"></span>
                                    </div>
                                    <div class="col-6 mb-2">
                                        <span class="bi bi-calendar text-gray-300 " data-toggle="tooltip" title="Registration Date"></span>
                                        <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Registration Date" id="registrationDate"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <br />
                                <br />
                                <center>
                                    <button class="btn btn-sm  mr-1 mt-1 btn-light" data-toggle="modal" onclick="ShowEdirModal()" data-target="#EditPatientModal" type="button" style="border-radius: 7px">
                                        <span class="bi bi-pencil text-gray-500"></span></button>
                                    <button class="btn btn-sm mr-1 mt-1  btn-light" data-toggle="modal" onclick="ShowDeleteModal()" data-target="#DeleteModal" type="button" style="border-radius: 7px">
                                        <span class="bi bi-trash text-gray-500"></span></button>
                                    <button class="btn btn-sm mr-1 mt-1  btn-light" data-toggle="modal" data-target="#transModal" onclick="GetInvoice()" type="button" style="border-radius: 7px">
                                        <span class="bi bi-envelope-check text-gray-500"></span></button>
                                    <button class="btn btn-sm mr-1 mt-1  btn-light" data-toggle="modal" data-target="#PatientHistoryModal" onclick="ShowHistoryModal();GetPatientHistory()" type="button" style="border-radius: 7px">
                                        <span class="bi bi-info-circle text-gray-500"></span></button>
                                    <button class="btn btn-sm mr-1 mt-1  btn-light" data-toggle="modal" data-target="#RequestModal" onclick="ShowRequestModal()" type="button" style="border-radius: 7px">
                                        <span class="bi bi-send-dash text-gray-500"></span>
                                    </button>
                                </center>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="RequestModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content" style="border-radius: 15px">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="bi bi-send-check mr-2" style="color: #ff00bb; font-size: 19px"></span>
                            <span class="align-items-center text-uppercase">Send Request</span>

                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-1 mt-2">
                            <div class="col-12">
                                <asp:DropDownList ID="ddlOpd" ClientIDMode="Static" class="form-control form-control-sm rounded-left rounded-right" runat="server">
                                    <asp:ListItem>-Select Room-</asp:ListItem>

                                </asp:DropDownList>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button  onclick="SendRequest()" class="btn btn-sm mx-2 mr-2 btn-danger" type="button" style="border-radius: 8px" runat="server">
                            <span class="bi bi-send-check mr-2"></span>Send

                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade " id="DeleteModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content" style="border-radius: 15px">
                <div class="modal-header">
                    <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                        <span class="bi bi-trash3 mr-2" style="color: #ff00bb; font-size: 19px"></span>
                        <span class="align-items-center text-uppercase">Delete Patient</span>

                    </h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row mb-2 ">
                        <div class="col-12 mb-2">
                            <span class="bi bi-patch-check text-gray-500 " data-toggle="tooltip" title="Injection Name"></span>
                            <span class="small text-gray-700 font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Injection Name">Are you sure you want to delete the patient ?</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button onclick="DeletePatient()" class="btn btn-sm mx-2 mr-2 btn-danger" type="button" style="border-radius: 8px" runat="server">
                        <span class="bi bi-trash mr-2"></span>Delete

                    </button>
                </div>
            </div>
        </div>
    </div>
    <script src="js/patient.js"></script>

    <script src="../opd/js/patient-history.js"></script>
</asp:Content>
