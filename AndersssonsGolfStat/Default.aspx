<%@ Page Title="Anderssons GolfStat | Rundor & Statistik" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AndersssonsGolfStat.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--Statusmeddelande--%>
    <asp:Panel ID="MessagePanel" runat="server" Visible="false" CssClass="msgPanel">
        <p><asp:Literal ID="MessageLiteral" runat="server" /></p>
        <asp:LinkButton ID="CloseButton" runat="server"  OnClientClick="return closeMessage();">[X]</asp:LinkButton>
    </asp:Panel>
    
    <%--Valideringsresultat--%>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validationMsg" />

    <%--Formulär för registrering av ny runda--%>
    <asp:Panel ID="InsertRoundDiv" runat="server" Visible="false" >
                    
        <h2>Registrera ny runda</h2>
        
        <asp:FormView ID="InsertFormView" runat="server"
            ItemType="AndersssonsGolfStat.Model.RoundData"
            InsertMethod="InsertFormView_InsertItem"
            DefaultMode="Insert"
            RenderOuterTable="false"
            DataKeyNames="CustomerId"
            OnItemCommand="InsertFormView_ItemCommand"> 

            <InsertItemTemplate>
                <table class="inputTable">
                    <tr>
                        <th>Datum</th>
                        <th>Bana</th>
                        <th>FIR</th>
                        <th>GIR</th>
                        
                        <th>Puttar</th>
                        <th>Plikt</th>
                        <th>Slag</th>
                        <th></th>
                    </tr>
                    <tr>
                        <td><asp:TextBox ID="Date" runat="server" Text='<%# BindItem.DateString %>' MaxLength="10" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Ett Datum måste anges." Display="None" ControlToValidate="Date" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Datum skall anges i formatet ÅÅÅÅ-MM-DD." Display="None" ControlToValidate="Date" SetFocusOnError="True" ValidationExpression="^(19|20)[0-9][0-9]-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$"></asp:RegularExpressionValidator>

                        <td><asp:DropDownList ID="NameDropDownList" runat="server"
                                ItemType="AndersssonsGolfStat.Model.Course"
                                SelectMethod="CoursesListView_GetData"
                                DataTextField="Name"
                                SelectedValue='<%# BindItem.Name %>' /></td>

                        <td><asp:TextBox ID="FIR" runat="server" Text='<%# BindItem.FIR %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Antalet FairwayInRegulation måste anges." Display="None" ControlToValidate="FIR" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Antal FairwayInRegulation kan max vara 18." Display="None" ControlToValidate="FIR" MaximumValue="18" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
                        
                        <td><asp:TextBox ID="GIR" runat="server" Text='<%# BindItem.GIR %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Antalet GreenInRegulation måste anges." Display="None" ControlToValidate="GIR" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Antal GreenInRegulation kan max vara 18." Display="None" ControlToValidate="GIR" MaximumValue="18" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>

                        <td><asp:TextBox ID="Putts" runat="server" Text='<%# BindItem.Putts %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Antalet Puttar måste anges." Display="None" ControlToValidate="Putts" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator3" runat="server" ErrorMessage="Antal Puttar kan max vara 99." Display="None" ControlToValidate="Putts" MaximumValue="99" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>

                        <td><asp:TextBox ID="Penalties" runat="server" Text='<%# BindItem.Penalties %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Antalet Plikt måste anges." Display="None" ControlToValidate="Penalties" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator4" runat="server" ErrorMessage="Antal Plikt kan max vara 99." Display="None" ControlToValidate="Penalties" MaximumValue="99" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>

                        <td><asp:TextBox ID="Strokes" runat="server" Text='<%# BindItem.Strokes %>'  MaxLength="3"/></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Antalet Slag måste anges." Display="None" ControlToValidate="Strokes" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Antal Slag skall vara inom intervallet 50 - 149." Display="None" ValidationExpression="^([5-9][0-9])|([0-1][0-4][0-9])$" SetFocusOnError="True" ControlToValidate="Strokes"></asp:RegularExpressionValidator>
                        <td>
                            <asp:LinkButton ID="InsertLinkButton" runat="server" CommandName="Insert" Text="Spara" CssClass="appButton" />
                            <asp:LinkButton ID="CancelLinkButton" runat="server" CommandName="Cancel" Text="Avbryt"  CssClass="appButton" CausesValidation="False" />
                        </td>
                    </tr>
                </table>
            </InsertItemTemplate>
        </asp:FormView>
    </asp:Panel>

    <%--Formulär för uppdatering av runda--%>
    <asp:Panel ID="UpdateRoundDiv" runat="server" Visible="false">
                    
        <h2>Redigera runda</h2>

        <asp:FormView ID="UpdateFormView" runat="server" 
            ItemType="AndersssonsGolfStat.Model.RoundData" 
            RenderOuterTable="false" 
            UpdateMethod="UpdateFormView_UpdateItem" 
            DeleteMethod="UpdateFormView_DeleteItem"
            DataKeyNames="RoundID" 
            DefaultMode="Edit" 
            SelectMethod="UpdateFormView_GetItem"
            ViewStateMode="Enabled"
            OnItemCommand="UpdateFormView_ItemCommand">
                        
            <EditItemTemplate>
                <table class="inputTable">
                    <tr>
                        <th>Datum</th>
                        <th>Bana</th>
                        <th>FIR</th>
                        <th>GIR</th>
                        <th>Puttar</th>
                        <th>Plikt</th>
                        <th>Slag</th>
                        <th></th>
                    </tr>
                    <tr>
                        <td><asp:TextBox ID="Date" runat="server" Text='<%# BindItem.DateString %>' MaxLength="10" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Ett Datum måste anges." Display="None" ControlToValidate="Date" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Datum skall anges i formatet ÅÅÅÅ-MM-DD." Display="None" ControlToValidate="Date" SetFocusOnError="True" ValidationExpression="^(19|20)[0-9][0-9]-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$"></asp:RegularExpressionValidator>

                        <td><asp:DropDownList ID="NameDropDownList" runat="server"
                                ItemType="AndersssonsGolfStat.Model.Course"
                                SelectMethod="CoursesListView_GetData"
                                DataTextField="Name"
                                SelectedValue='<%# BindItem.Name %>' /></td>

                        <td><asp:TextBox ID="FIR" runat="server" Text='<%# BindItem.FIR %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Antalet FairwayInRegulation måste anges." Display="None" ControlToValidate="FIR" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Antal FairwayInRegulation kan max vara 18." Display="None" ControlToValidate="FIR" MaximumValue="18" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
                       
                        <td><asp:TextBox ID="GIR" runat="server" Text='<%# BindItem.GIR %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Antalet GreenInRegulation måste anges." Display="None" ControlToValidate="GIR" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Antal GreenInRegulation kan max vara 18." Display="None" ControlToValidate="GIR" MaximumValue="18" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>

                        <td><asp:TextBox ID="Putts" runat="server" Text='<%# BindItem.Putts %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Antalet Puttar måste anges." Display="None" ControlToValidate="Putts" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator3" runat="server" ErrorMessage="Antal Puttar kan max vara 99." Display="None" ControlToValidate="Putts" MaximumValue="99" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>

                        <td><asp:TextBox ID="Penalties" runat="server" Text='<%# BindItem.Penalties %>' MaxLength="2" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Antalet Plikt måste anges." Display="None" ControlToValidate="Penalties" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator4" runat="server" ErrorMessage="Antal Plikt kan max vara 99." Display="None" ControlToValidate="Penalties" MaximumValue="99" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>

                        <td><asp:TextBox ID="Strokes" runat="server" Text='<%# BindItem.Strokes %>' MaxLength="3" /></td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Antalet Slag måste anges." Display="None" ControlToValidate="Strokes" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Antal Slag skall vara inom intervallet 50 - 149." Display="None" ValidationExpression="^([5-9][0-9])|([0-1][0-4][0-9])$" SetFocusOnError="True" ControlToValidate="Strokes"></asp:RegularExpressionValidator>
                        
                        <td><asp:HyperLink ID="CancelHyperLink" runat="server" Text="Avbryt" NavigateUrl="~/Default.aspx" CssClass="appButton" />
                            <asp:LinkButton ID="UpdateHyperLink" runat="server" CommandName="Update" Text="Spara" CssClass="appButton" />
                            <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" Text="Delete" CssClass="appButton" 
                                OnClientClick='<%# String.Format("return confirm(\"Ta bort rundan spelad på {0} den {1}?\")",Item.Name, Item.Date.ToShortDateString()) %>' CausesValidation="False" /></td>
                    </tr>
                </table>
            </EditItemTemplate>
        </asp:FormView>
    </asp:Panel>

    


    <h2>Mina Rundor</h2>

    <%--Tabell över spelade rundor--%>

    <asp:ListView ID="RoundDataListView" runat="server"
        ItemType="AndersssonsGolfStat.Model.RoundData"
        SelectMethod="RoundDataListView_GetDataPageWise"
        DataKeyNames="RoundID"
        OnItemCommand="RoundDataListView_ItemCommand">

        <LayoutTemplate>
            <table id="RoundDataTable">
                <thead>
                    <tr>
                        <th>Datum</th>
                        <th>Bana</th>
                        <th>FIR</th>
                        <th>%</th>
                        <th>GIR</th>
                        <th>%</th>
                        <th>Puttar</th>
                        <th>Snitt</th>
                        <th>Plikt</th>
                        <th>Slag</th>
                        <th>Brutto</th>
                        <th><asp:LinkButton ID="NewLinkButton" runat="server" CommandName="New" Text="Ny runda" CssClass="newButton" CausesValidation="False" /></th>
                    </tr>
                </thead>
                <tbody>
                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                </tbody>
            </table>
            <div class="pager">
                <asp:DataPager ID="DataPager1" runat="server" PageSize="10">
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
                <td><%# Item.DateString %></td>
                <td><%# Item.Name %></td>
                <td><%# Item.FIR %></td>
                <td><%# string.Format("{0:p0}",Item.FIRpro) %></td>
                <td><%# Item.GIR %></td>
                <td><%# string.Format("{0:p0}",Item.GIRpro) %></td>
                <td><%# Item.Putts %></td>
                <td><%# string.Format("{0:f1}",Item.Puttsavg) %></td>
                <td><%# Item.Penalties %></td>
                <td><%# Item.Strokes %></td>
                <td><%# Item.Brutto %></td>
                <td><asp:LinkButton ID="EditLinkButton" runat="server" CommandName="Edit" PostBackUrl='<%# Eval("RoundID","~/Default.aspx?RID={0}" ) %>' CausesValidation="False">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Content/Pic/edit.png" CssClass="editButton" />
                    </asp:LinkButton></td>
            </tr>
        </ItemTemplate>
    </asp:ListView>

    <%--Statistik över spelade rundor--%>
    
    <h2>Min Statistik</h2>

    <div class="statBox">
        <div class="statBoxHeader">
            <h3>Allmänt</h3>
        </div>
        <span>Antal rundor</span>
        <span><asp:Literal ID="RoundsLiteral" runat="server" /></span>
        <span>Antal hål</span>
        <span><asp:Literal ID="HolesLiteral" runat="server" /></span>
    </div>

    <div class="statBox">
        <div class="statBoxHeader">
            <h3>Resultat & Slag</h3>
            <p><asp:Literal ID="BruttoavgLiteral" runat="server" /></p>
        </div>
        <span>Antal slag totalt</span>
        <span><asp:Literal ID="StrokesLiteral" runat="server" /></span>
        <span><asp:Literal ID="RoundsCountLiteral5" runat="server" /> senaste rundorna</span>
        <span><asp:Literal ID="LatestBruttoavgLiteral" runat="server" /></span>
    </div>

    <div class="statBox">
        <div class="statBoxHeader">
            <h3>Pliktslag</h3>
            <p><asp:Literal ID="PenaltiesavgLiteral" runat="server" /> / runda</p>
        </div>
        <span>Antal plikt totalt</span>
        <span><asp:Literal ID="PenaltiesLiteral" runat="server" /></span>
        <span><asp:Literal ID="RoundsCountLiteral4" runat="server" /> senaste rundorna</span>
        <span><asp:Literal ID="LatestPenaltiesavgLiteral" runat="server" /> / runda</span>
    </div>

    <div class="statBox">
        <div class="statBoxHeader">
            <h3>Fairwayträffar</h3>
            <p><asp:Literal ID="FIRproLiteral" runat="server" /></p>
        </div>
        <span>Antal</span>
        <span><asp:Literal ID="FIRLiteral" runat="server" /></span>
        <span><asp:Literal ID="RoundsCountLiteral2" runat="server" /> senaste rundorna</span>
        <span><asp:Literal ID="LatestFIRproLiteral" runat="server" /></span>
    </div>

    <div class="statBox">
        <div class="statBoxHeader">
            <h3>Greenträffar</h3>
            <p><asp:Literal ID="GIRproLiteral" runat="server" /></p>
        </div>
        <span>Antal</span>
        <span><asp:Literal ID="GIRLiteral" runat="server" /></span>
        <span>Snitt/runda</span>
        <span><asp:Literal ID="GIRavgLiteral" runat="server" /></span>
        <span><asp:Literal ID="RoundsCountLiteral1" runat="server" /> senaste rundorna</span>
        <span><asp:Literal ID="LatestGIRpro" runat="server" /></span>
    </div>

    <div class="statBox">
        <div class="statBoxHeader">
            <h3>Puttar</h3>
            <p><asp:Literal ID="PuttsHoleLiteral" runat="server" /> / hål</p>
        </div>
        <span>Antal</span>
        <span><asp:Literal ID="PuttsLiteral" runat="server" /></span>
        <span>Snitt / Runda</span>
        <span><asp:Literal ID="PuttsRoundLiteral" runat="server" /></span>
        <span><asp:Literal ID="RoundsCountLiteral3" runat="server" /> senaste rundorna</span>
        <span><asp:Literal ID="LatestPuttsavgLiteral" runat="server" /> / hål</span>
    </div>

</asp:Content>