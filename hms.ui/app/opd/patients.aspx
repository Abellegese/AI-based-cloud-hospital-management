<%@ Page Title="" Language="C#" MasterPageFile="~/app/opd/app.Master" AutoEventWireup="true" CodeBehind="patients.aspx.cs" Inherits="hms.ui.app.opd.patients" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Patients</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid pl-3 pr-3" style="position: absolute;" id="container" runat="server">
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
                        <div class="row mb-1" id="dateRangeDiv">
                            <div class="col-6">
                                <asp:TextBox ID="txtDateFrom" ClientIDMode="Static" data-toggle="tooltip" title="From Date" TextMode="Date" class="form-control form-control-sm rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-6">
                                <asp:TextBox ID="txtDateTo" ClientIDMode="Static" data-toggle="tooltip" title="To Date" TextMode="Date" class="form-control form-control-sm  rounded-left rounded-right" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-2 border-bottom">
                            <div class="col-12">
                                <span class="bi bi-archive text-gray-300 " data-toggle="tooltip" title="Status"></span>
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Status">STATUS</span>
                            </div>
                        </div>
                        <div class="row mb-1 mt-2" id="typeDiv">
                            <div class="col-12">
                                <asp:DropDownList ID="ddlStatus" ClientIDMode="Static" class="form-control form-control-sm rounded-left rounded-right" runat="server">
                                    <asp:ListItem>Pending</asp:ListItem>
                                    <asp:ListItem>Paid</asp:ListItem>
                                    <asp:ListItem>All</asp:ListItem>

                                </asp:DropDownList>
                            </div>

                        </div>

                        <div class="row mb-2 border-bottom" id="custVendDiv">
                            <div class="col-12">
                                <span class="bi bi-archive text-gray-300 " data-toggle="tooltip" title="Customer or Vendor"></span>
                                <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Customer or Vendor">Select Customer or Vendor</span>
                            </div>
                        </div>
                        <div class="row mb-1 mt-2">
                            <div class="col-12">
                                <asp:DropDownList ID="ddlCustomerVendor" ClientIDMode="Static" class="form-control form-control-sm rounded-left rounded-right" runat="server">
                                </asp:DropDownList>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:LinkButton ID="btnFilterRecord" OnClientClick="ShowLoader()" class="btn btn-sm mx-2 mr-2 btn-danger" Style="border-radius: 8px" runat="server"><span class="fas fa-sync mr-2"></span>Fetch</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="modal fade " id="patientDetailModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content" style="border-radius: 19px">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="bi bi-briefcase mr-2" style="color: #ff00bb; font-size: 20px"></span>
                            PATIENT DETAILS [REG#<span id="regNumber"></span>]
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body" style="max-height: 400px; overflow-y: scroll">
                        <div class="row mb-2 align-items-center">
                            <div class="col-5 mb-2">
                                <div class="row mb-2">
                                    <div class="col-12 mb-2">
                                        <span class="bi bi-pie-chart text-gray-500 " data-toggle="tooltip" title="Date Range"></span>
                                        <span class="small text-gray-500 text-uppercase font-weight-light badge badge-light mr-1" data-toggle="tooltip" title="Disease Statistics">Disease Pattern</span>
                                    </div>
                                </div>

                            </div>
                            <div class="col-7 mb-2 ">
                            </div>
                            <div class="col-12">
                                <br />
                                <br />
                                <center>
                                    <button class="btn btn-sm  mr-1 mt-1 btn-light" data-toggle="modal" data-target="#RecieveCreditModal" onclick="BindCredit()" type="button" style="border-radius: 7px">
                                        <span class="bi bi-file-arrow-down text-gray-500"></span>
                                    </button>
                                    <button class="btn btn-sm mr-1 mt-1  btn-light" data-toggle="modal" data-target="#transModal" onclick="GetInvoice()" type="button" style="border-radius: 7px">
                                        <span class="bi bi-envelope-check text-gray-500"></span>
                                    </button>
                                    <button class="btn btn-sm mr-1 mt-1  btn-light" data-toggle="modal" data-target="#transModal" onclick="GetInvoice()" type="button" style="border-radius: 7px">
                                        <span class="bi bi-info-circle text-gray-500"></span>
                                    </button>
                                </center>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>
    </div>

    <script src="js/patient.js"></script>
</asp:Content>
