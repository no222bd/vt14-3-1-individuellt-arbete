<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="AndersssonsGolfStat.Courses" ViewStateMode="Disabled" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <link href="Content/style.css" rel="stylesheet" />
    <title>Anderssons GolfStat | Banor</title>
</head>
<body>
    <div id="container">
        <header>
            <h1>Anderssons GolfStat</h1>
        </header>
        <nav>
            
            <ul>
                <li><a href="Default.aspx">Rundor & Statistik</a></li>
                <li><a href="Courses.aspx">Redigera banor</a></li>
            </ul>
        </nav>
        <div id="content">
            <%--Master--%>

            <h2>Registrerade banor</h2>

            <form id="form1" runat="server">
             
                <asp:ListView ID="CourseListView" runat="server"
                    ItemType="AndersssonsGolfStat.Model.Course"
                    SelectMethod="CourseListView_GetData"
                    DataKeyNames="CourseID"
                    OnItemCommand="CourseListView_ItemCommand" >

                    <LayoutTemplate>
                        <table>
                            <tr>
                                <th>Bana</th>
                                <th>Par</th>
                                <th>Fairways</th>
                                <th><asp:LinkButton ID="NewLinkButton" runat="server" Text="Ny Bana" CommandName="New" /></th>
                            </tr>
                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Item.Name %></td>
                            <td><%# Item.Par %></td>
                            <td><%# Item.Fairways %></td>
                            <td><asp:LinkButton ID="UpdateLinkButton" runat="server" Text="Edit" CommandName="Edit" PostBackUrl='<%# Eval("CourseID","~/Courses.aspx?CID={0}" ) %>' /></td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>

                <asp:Panel ID="InsertPanel" runat="server" Visible="false">

                    <h2>Registrera ny bana</h2>

                    <asp:FormView ID="NewFormView" runat="server"
                        InsertMethod="NewFormView_InsertItem"
                        ItemType="AndersssonsGolfStat.Model.Course"
                        DataKeyNames="CourseID"
                        DefaultMode="Insert"
                        RenderOuterTable="false">

                        <InsertItemTemplate>
                            <table>
                                <tr>
                                    <th>Namn</th>
                                    <th>Par</th>
                                    <th>Fairways</th>
                                    <th></th>
                                </tr>
                                <tr>
                                    <td><asp:TextBox ID="Name" runat="server" Text='<%# BindItem.Name %>' /></td>
                                    <td><asp:TextBox ID="Par" runat="server" Text='<%# BindItem.Par %>' /></td>
                                    <td><asp:TextBox ID="Fairways" runat="server" Text='<%# BindItem.Fairways %>' /></td>
                                    <td>
                                        <asp:LinkButton ID="InsertLinkButton" runat="server" CommandName="Insert" Text="Spara" />
                                        <asp:LinkButton ID="CancelLinkButton" runat="server" CommandName="Cancel" Text="Avbryt" />
                                    </td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                    </asp:FormView>
                </asp:Panel>

                <asp:Panel ID="UpdatePanel" runat="server" Visible="false">

                    <h2>Redigera bana</h2>

                    <asp:FormView ID="UpdateFormView" runat="server"
                        DeleteMethod="UpdateFormView_DeleteItem"
                        SelectMethod="UpdateFormView_GetItem"
                        UpdateMethod="UpdateFormView_UpdateItem"
                        ItemType="AndersssonsGolfStat.Model.Course"
                        DataKeyNames="CourseID"
                        DefaultMode="Edit"
                        RenderOuterTable="false"
                        ViewStateMode="Enabled"
                        ><%--============================================================================================================VievStateMode--%>

                        <EditItemTemplate>
                            <table>
                                <tr>
                                    <th>Namn</th>
                                    <th>Par</th>
                                    <th>Fairways</th>
                                    <th></th>
                                </tr>
                                <tr>
                                    <td><asp:TextBox ID="Name" runat="server" Text='<%# BindItem.Name %>' /></td>
                                    <td><asp:TextBox ID="Par" runat="server" Text='<%# BindItem.Par %>' /></td>
                                    <td><asp:TextBox ID="Fairways" runat="server" Text='<%# BindItem.Fairways %>' /></td>
                                    <td>
                                        <asp:HyperLink ID="CancelHyperLink" runat="server" Text="Avbryt" NavigateUrl="~/Courses.aspx" />
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" Text="Ta bort" />
                                        <asp:LinkButton ID="UpdateLinkButton" runat="server" CommandName="Update" Text="Spara" />
                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                    </asp:FormView>
                </asp:Panel>

               



















            </form>
        </div><!-- content -->

        <footer>
            <p>Nils-Jakob Olsson / no222bd / WP2012 Distans</p>
        </footer>
    </div><!-- container -->
</body>
</html>
