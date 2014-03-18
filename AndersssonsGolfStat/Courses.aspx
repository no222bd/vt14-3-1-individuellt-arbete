<%@ Page Title="Anderssons GolfStat | Banor" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="AndersssonsGolfStat.Courses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <%--Statusmeddelande--%>
    <asp:Panel ID="MessagePanel" runat="server" Visible="false" CssClass="msgPanel">
        <p><asp:Literal ID="MessageLiteral" runat="server" /></p>
        <asp:LinkButton ID="CloseButton" runat="server"  OnClientClick="return closeMessage();">[X]</asp:LinkButton>
    </asp:Panel>
    
    <%--Valideringsresultat--%>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validationMsg" />
             
    <%--Formulär för registrering av ny bana--%>
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Ett namn måste anges." Display="None" ControlToValidate="Name" SetFocusOnError="True" />
                        
                        <td><asp:TextBox ID="Par" runat="server" Text='<%# BindItem.Par %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Banans Par måste anges." Display="None" ControlToValidate="Par" SetFocusOnError="True" />
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Par måste vara i intervallet 60 - 80" Display="None" ControlToValidate="Par" MaximumValue="80" MinimumValue="60" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
                        
                        <td><asp:TextBox ID="Fairways" runat="server" Text='<%# BindItem.Fairways %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Antal möjliga fairwayträffar måste anges." Display="None" ControlToValidate="Fairways" SetFocusOnError="True" />
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Antal fairways kan max vara 18" Display="None" ControlToValidate="Fairways" MaximumValue="18" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
                        
                        <td>
                            <asp:LinkButton ID="InsertLinkButton" runat="server" CommandName="Insert" Text="Spara" CssClass="appButton"/>
                            <asp:LinkButton ID="CancelLinkButton" runat="server" CommandName="Cancel" Text="Avbryt" CssClass="appButton" CausesValidation="False" />
                        </td>
                    </tr>
                </table>
            </InsertItemTemplate>
        </asp:FormView>
    </asp:Panel>

    <%--Formulär för uppdatering av bana--%>
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Ett namn måste anges." Display="None" ControlToValidate="Name" SetFocusOnError="True" />

                        <td><asp:TextBox ID="Par" runat="server" Text='<%# BindItem.Par %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Banans Par måste anges." Display="None" ControlToValidate="Par" SetFocusOnError="True" />
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Par måste vara i intervallet 60 - 80" Display="None" ControlToValidate="Par" MaximumValue="80" MinimumValue="60" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
                        
                        <td><asp:TextBox ID="Fairways" runat="server" Text='<%# BindItem.Fairways %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Antal möjliga fairwayträffar måste anges." Display="None" ControlToValidate="Fairways" SetFocusOnError="True" />
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Antal fairways kan max vara 18" Display="None" ControlToValidate="Fairways" MaximumValue="18" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
                        
                        <td>
                            <asp:HyperLink ID="CancelHyperLink" runat="server" Text="Avbryt" NavigateUrl="~/Courses.aspx" CssClass="appButton" />
                            <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" Text="Ta bort" CssClass="appButton" OnClientClick='<%# String.Format("return confirm(\"Ta bort banan{0}?\")",Item.Name) %>' CausesValidation="False" />
                            <asp:LinkButton ID="UpdateLinkButton" runat="server" CommandName="Update" Text="Spara" CssClass="appButton" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
        </asp:FormView>
    </asp:Panel>

    <h2>Registrerade banor</h2>

    <%--Tabell innehållandes data om spelade rundor--%>

    <asp:ListView ID="CourseListView" runat="server"
        ItemType="AndersssonsGolfStat.Model.Course"
        SelectMethod="CourseListView_GetDataPageWise"
        DataKeyNames="CourseID"
        OnItemCommand="CourseListView_ItemCommand">

        <LayoutTemplate>
            <table id="courseTable">
                <tr>
                    <th>Bana</th>
                    <th>Par</th>
                    <th>Fairways</th>
                    <th><asp:LinkButton ID="NewLinkButton" runat="server" Text="Ny Bana" CommandName="New"  CssClass="newButton" CausesValidation="False" /></th>
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
                <td><asp:LinkButton ID="UpdateLinkButton" runat="server" CommandName="Edit" PostBackUrl='<%# Eval("CourseID","~/Courses.aspx?CID={0}" ) %>' CausesValidation="False">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Content/Pic/edit.png" CssClass="editButton" />
                    </asp:LinkButton></td>
            </tr>
        </ItemTemplate>
    </asp:ListView>
</asp:Content>
