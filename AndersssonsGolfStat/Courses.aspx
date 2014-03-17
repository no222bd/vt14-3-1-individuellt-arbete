<%@ Page Title="Anderssons GolfStat | Banor" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="AndersssonsGolfStat.Courses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:Panel ID="MessagePanel" runat="server" Visible="false" CssClass="msgPanel">
        <p><asp:Literal ID="MessageLiteral" runat="server" /></p>
        <asp:LinkButton ID="CloseButton" runat="server"  OnClientClick="return closeMessage();">[X]</asp:LinkButton>
    </asp:Panel>
    
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validationMsg" />

    <h2>Registrerade banor</h2>
             
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
                        <td><asp:TextBox ID="Name" runat="server" Text='<%# BindItem.Name %>' MaxLength="30" /></td>
                        <td><asp:TextBox ID="Par" runat="server" Text='<%# BindItem.Par %>' MaxLength="2" /></td>
                        <td><asp:TextBox ID="Fairways" runat="server" Text='<%# BindItem.Fairways %>' MaxLength="2" /></td>
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
            ViewStateMode="Enabled">

            <EditItemTemplate>
                <table>
                    <tr>
                        <th>Namn</th>
                        <th>Par</th>
                        <th>Fairways</th>
                        <th></th>
                    </tr>
                    <tr>
                        <td><asp:TextBox ID="Name" runat="server" Text='<%# BindItem.Name %>' MaxLength="30"/></td>
                        <td><asp:TextBox ID="Par" runat="server" Text='<%# BindItem.Par %>' MaxLength="2" /></td>
                        <td><asp:TextBox ID="Fairways" runat="server" Text='<%# BindItem.Fairways %>' MaxLength="2" /></td>
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

</asp:Content>
