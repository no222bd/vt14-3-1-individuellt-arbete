<%@ Page Title="Anderssons GolfStat | Rundor & Statistik" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AndersssonsGolfStat.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="MessagePanel" runat="server" Visible="false" >
        <p><asp:Literal ID="MessageLiteral" runat="server" /></p>
        <asp:LinkButton ID="CloseButton" runat="server"  OnClientClick="return closeMessage();">[X]</asp:LinkButton>
    </asp:Panel>
    


    <asp:Panel ID="InsertRoundDiv" runat="server" Visible="false">
                    
        <h2>Registrera ny runda</h2>
        
        <asp:FormView ID="InsertFormView" runat="server"
            ItemType="AndersssonsGolfStat.Model.RoundData"
            InsertMethod="InsertFormView_InsertItem"
            DefaultMode="Insert"
            RenderOuterTable="false"
            DataKeyNames="CustomerId">

            <InsertItemTemplate>
                <table>
                    <tr>
                        <th>Datum</th>
                        <th>Bana</th>
                        <th>GIR</th>
                        <th>FIR</th>
                        <th>Puttar</th>
                        <th>Plikt</th>
                        <th>Slag</th>
                        <th></th>
                    </tr>
                    <tr>
                        <td><asp:TextBox ID="Date" runat="server" Text='<%# BindItem.Date %>' MaxLength="10" /></td>
                        <td><asp:DropDownList ID="NameDropDownList" runat="server"
                                ItemType="AndersssonsGolfStat.Model.Course"
                                SelectMethod="CoursesListView_GetData"
                                DataTextField="Name"
                                SelectedValue='<%# BindItem.Name %>' /></td>
                        <td><asp:TextBox ID="FIR" runat="server" Text='<%# BindItem.FIR %>' MaxLength="2" /></td>
                        <td><asp:TextBox ID="GIR" runat="server" Text='<%# BindItem.GIR %>' MaxLength="2" /></td>
                        <td><asp:TextBox ID="Putts" runat="server" Text='<%# BindItem.Putts %>' MaxLength="2" /></td>
                        <td><asp:TextBox ID="Penalties" runat="server" Text='<%# BindItem.Penalties %>' MaxLength="2" /></td>
                        <td><asp:TextBox ID="Strokes" runat="server" Text='<%# BindItem.Strokes %>'  MaxLength="3"/></td>
                        <td>
                            <asp:LinkButton ID="InsertLinkButton" runat="server" CommandName="Insert" Text="Spara" />
                            <asp:LinkButton ID="CancelLinkButton" runat="server" CommandName="Cancel" Text="Avbryt" />
                        </td>
                    </tr>
                </table>
            </InsertItemTemplate>
        </asp:FormView>
    </asp:Panel>

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
            ViewStateMode="Enabled">
                        
            <EditItemTemplate>
                <table>
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
                        <td><asp:DropDownList ID="NameDropDownList" runat="server"
                                ItemType="AndersssonsGolfStat.Model.Course"
                                SelectMethod="CoursesListView_GetData"
                                DataTextField="Name"
                                SelectedValue='<%# BindItem.Name %>' /></td>
                        <td><asp:TextBox ID="FIR" runat="server" Text='<%# BindItem.FIR %>' MaxLength="2" /></td>
                        <td></td>
                        <td><asp:TextBox ID="GIR" runat="server" Text='<%# BindItem.GIR %>' MaxLength="2" /></td>
                        <td></td>
                        <td><asp:TextBox ID="Putts" runat="server" Text='<%# BindItem.Putts %>' MaxLength="2" /></td>
                        <td></td>
                        <td><asp:TextBox ID="Penalties" runat="server" Text='<%# BindItem.Penalties %>' MaxLength="2" /></td>
                        <td><asp:TextBox ID="Strokes" runat="server" Text='<%# BindItem.Strokes %>' MaxLength="3" /></td>
                        <td></td>
                        <td><asp:HyperLink ID="CancelHyperLink" runat="server" Text="Avbryt" NavigateUrl="~/Default.aspx" CssClass="appButton" />
                            <asp:LinkButton ID="UpdateHyperLink" runat="server" CommandName="Update" Text="Spara" CssClass="appButton" />
                            <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" Text="Delete" CssClass="appButton" /></td>
                    </tr>
                </table>
            </EditItemTemplate>
        </asp:FormView>
    </asp:Panel>

    <h2>Mina Rundor</h2>

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
                        <th><asp:LinkButton ID="NewLinkButton" runat="server" CommandName="New" Text="Ny runda" CssClass="newButton" /></th>
                    </tr>
                </thead>
                <tbody>
                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                </tbody>
            </table>
            <div id="pager">
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
                <td><asp:LinkButton ID="EditLinkButton" runat="server" CommandName="Edit" PostBackUrl='<%# Eval("RoundID","~/Default.aspx?RID={0}" ) %>'>
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Content/Pics/edit.png" CssClass="editButton" />
                    </asp:LinkButton></td>
            </tr>
        </ItemTemplate>
    </asp:ListView>

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