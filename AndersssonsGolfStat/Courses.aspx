<%@ Page Title="Anderssons GolfStat | Banor" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="AndersssonsGolfStat.Courses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:Panel ID="MessagePanel" runat="server" Visible="false" CssClass="msgPanel">
        <p><asp:Literal ID="MessageLiteral" runat="server" /></p>
        <asp:LinkButton ID="CloseButton" runat="server"  OnClientClick="return closeMessage();">[X]</asp:LinkButton>
    </asp:Panel>
    
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validationMsg" />

  
             
    <asp:Panel ID="InsertPanel" runat="server" Visible="false">

        <h2>Registrera ny bana</h2>

        <asp:FormView ID="NewFormView" runat="server"
            InsertMethod="NewFormView_InsertItem"
            ItemType="AndersssonsGolfStat.Model.Course"
            DataKeyNames="CourseID"
            DefaultMode="Insert"
            RenderOuterTable="false" OnItemCommand="InsertFormView_ItemCommand">

            <InsertItemTemplate>
                <table id="inputCourseTable" class="inputTable">
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
                            <asp:LinkButton ID="InsertLinkButton" runat="server" CommandName="Insert" Text="Spara" CssClass="appButton"/>
                            <asp:LinkButton ID="CancelLinkButton" runat="server" CommandName="Cancel" Text="Avbryt" CssClass="appButton" />
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
            OnItemCommand="UpdateFormView_ItemCommand">

            <EditItemTemplate>
                <table id="inputCourseTable" class="inputTable">
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
                            <asp:HyperLink ID="CancelHyperLink" runat="server" Text="Avbryt" NavigateUrl="~/Courses.aspx" CssClass="appButton" />
                            <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" Text="Ta bort" CssClass="appButton"
                              OnClientClick='<%# String.Format("return confirm(\"Ta bort banan{0}?\")",Item.Name) %>'  
                                />
                            <asp:LinkButton ID="UpdateLinkButton" runat="server" CommandName="Update" Text="Spara" CssClass="appButton" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
        </asp:FormView>
    
    </asp:Panel>

      <h2>Registrerade banor</h2>

    <asp:ListView ID="CourseListView" runat="server"
        ItemType="AndersssonsGolfStat.Model.Course"
        SelectMethod="CourseListView_GetDataPageWise"
        DataKeyNames="CourseID"
        OnItemCommand="CourseListView_ItemCommand"
         >

        <LayoutTemplate>
            <table id="courseTable">
                <tr>
                    <th>Bana</th>
                    <th>Par</th>
                    <th>Fairways</th>
                    <th><asp:LinkButton ID="NewLinkButton" runat="server" Text="Ny Bana" CommandName="New"  CssClass="newButton"/></th>
                </tr>
                <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
            </table>
            <div id="pager" class="pager">
                <asp:DataPager ID="DataPager1" runat="server" PageSize="5">
                    <Fields>
                        <asp:NextPreviousPagerField ShowNextPageButton="False" RenderDisabledButtonsAsLabels="False" PreviousPageText="<" ButtonCssClass="pagingButtons" />
                        <asp:NumericPagerField ButtonCount="30" RenderNonBreakingSpacesBetweenControls="True" CurrentPageLabelCssClass="currentPage" NumericButtonCssClass="pagingButtons" />
                        <asp:NextPreviousPagerField ShowPreviousPageButton="False" NextPageText=">" RenderDisabledButtonsAsLabels="False" ButtonCssClass="pagingButtons" />
                    </Fields>
                </asp:DataPager>        
            </div>
        </LayoutTemplate>
        
        <ItemTemplate>
            <tr>
                <td><%# Item.Name %></td>
                <td><%# Item.Par %></td>
                <td><%# Item.Fairways %></td>
                <td><asp:LinkButton ID="UpdateLinkButton" runat="server" CommandName="Edit" PostBackUrl='<%# Eval("CourseID","~/Courses.aspx?CID={0}" ) %>' >
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Content/Pics/edit.png" CssClass="editButton" />
                    </asp:LinkButton></td>
            </tr>
        </ItemTemplate>
    </asp:ListView>

    

</asp:Content>
