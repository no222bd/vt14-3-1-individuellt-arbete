<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AndersssonsGolfStat.Default" ViewStateMode="Disabled" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <link href="Content/style.css" rel="stylesheet" />
    <title>Anderssons GolfStat</title>
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

            <h2>Mina Rundor</h2>

            <form id="form1" runat="server">
             
                <asp:ListView ID="TableRowListView" runat="server"
                    ItemType="AndersssonsGolfStat.Model.TableRow"
                    SelectMethod="TableRowListView_GetData"
                    DataKeyNames="RoundID"
                    OnItemCommand="TableRowListView_ItemCommand">

                    <LayoutTemplate>
                        <table>
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
                                <th><asp:LinkButton ID="NewLinkButton" runat="server" CommandName="New" Text="Ny runda" /></th>
                            </tr>
                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                            <%--<tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><asp:LinkButton ID="NewLinkButton" runat="server" CommandName="New" Text="Ny runda" /></td>
                            </tr>--%>
                        </table>
                    </LayoutTemplate>

                    <ItemTemplate>
                        <tr>
                            <td><%# Item.Date.ToShortDateString() %></td>
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
                            <td>
                                <%--<asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" Text="DEL" />--%>
                               <%-- <asp:LinkButton ID="EditLink_Button" runat="server" CommandName="lala" Text="EDIT" CommandArgument='<%# Item.RoundID %>' />--%>
                             <%--<asp:HyperLink ID="EditHyperLink" runat="server" Text="edit" NavigateUrl='<%# Eval("RoundID","~/Default.aspx?RID={0}" ) %>' />--%>

                                <asp:LinkButton ID="EditLinkButton" runat="server" CommandName="Edit" Text="edit" PostBackUrl='<%# Eval("RoundID","~/Default.aspx?RID={0}" ) %>' /><%--CommandArgument="Show"--%>


                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>

                <asp:Panel ID="InsertRoundDiv" runat="server" Visible="false">
                    
                    <h2>Registrera ny runda</h2>

                    <asp:FormView ID="InsertFormView" runat="server"
                        ItemType="AndersssonsGolfStat.Model.TableRow"
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
                                    <td>
                                        <asp:TextBox ID="Date" runat="server" Text='<%# BindItem.Date %>' /></td>
                                    <td>
                                        <asp:DropDownList ID="NameDropDownList" runat="server"
                                            ItemType="AndersssonsGolfStat.Model.Course"
                                            SelectMethod="CoursesListView_GetData"
                                            DataTextField="Name"
                                            SelectedValue='<%# BindItem.Name %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="FIR" runat="server" Text='<%# BindItem.FIR %>' MaxLength="2" /></td>
                                    <td>
                                        <asp:TextBox ID="GIR" runat="server" Text='<%# BindItem.GIR %>' /></td>
                                    <td>
                                        <asp:TextBox ID="Putts" runat="server" Text='<%# BindItem.Putts %>' /></td>
                                    <td>
                                        <asp:TextBox ID="Penalties" runat="server" Text='<%# BindItem.Penalties %>' /></td>
                                    <td>
                                        <asp:TextBox ID="Strokes" runat="server" Text='<%# BindItem.Strokes %>' /></td>
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
                        ItemType="AndersssonsGolfStat.Model.TableRow" 
                        RenderOuterTable="false" 
                        UpdateMethod="UpdateFormView_UpdateItem" 
                        DeleteMethod="UpdateFormView_DeleteItem"
                        DataKeyNames="RoundID" 
                        DefaultMode="Edit" 
                        SelectMethod="UpdateFormView_GetItem" >
                        
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
                                    <td>
                                        <asp:TextBox ID="Date" runat="server" Text='<%# BindItem.Date %>' /></td>
                                    <td>
                                        <asp:DropDownList ID="NameDropDownList" runat="server"
                                            ItemType="AndersssonsGolfStat.Model.Course"
                                            SelectMethod="CoursesListView_GetData"
                                            DataTextField="Name"
                                            SelectedValue='<%# BindItem.Name %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="FIR" runat="server" Text='<%# BindItem.FIR %>' MaxLength="2" /></td>
                                    <td></td>
                                    <td>
                                        <asp:TextBox ID="GIR" runat="server" Text='<%# BindItem.GIR %>' /></td>
                                    <td></td>
                                    <td>
                                        <asp:TextBox ID="Putts" runat="server" Text='<%# BindItem.Putts %>' /></td>
                                    <td></td>
                                    <td>
                                        <asp:TextBox ID="Penalties" runat="server" Text='<%# BindItem.Penalties %>' /></td>
                                    <td>
                                        <asp:TextBox ID="Strokes" runat="server" Text='<%# BindItem.Strokes %>' /></td>
                                    <td></td>
                                    <td>
                                        <%--<asp:LinkButton ID="UpdateLinkButton" runat="server" CommandName="Delete" Text="Ta bort" />
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Update" Text="Spara" />--%>
                                        <%--<asp:LinkButton ID="CancelLinkButton" runat="server" CommandName="Cancel" Text="Avbryt" />--%>
                                        <asp:HyperLink ID="CancelHyperLink" runat="server" Text="Avbryt" NavigateUrl="~/Default.aspx" />
                                        <asp:LinkButton ID="UpdateHyperLink" runat="server" CommandName="Update" Text="Spara" />
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" Text="Delete" />

                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                    </asp:FormView>
                </asp:Panel>

                <div id="tmpförsynsskull">

                <h2>Min Statistik</h2>

                <div class="statBox">
                    <div class="statBoxHeader">
                        <h3>Allmänt</h3>
                    </div>
                    <span>Antal rundor</span>
                    <span>
                        <asp:Literal ID="RoundsLiteral" runat="server" /></span>
                    <span>Antal hål</span>
                    <span>
                        <asp:Literal ID="HolesLiteral" runat="server" /></span>
                </div>

                <div class="statBox">
                    <div class="statBoxHeader">
                        <h3>Resultat & Slag</h3>
                        <p>
                            <asp:Literal ID="BruttoavgLiteral" runat="server" /></p>
                    </div>
                    <span>Antal slag totalt</span>
                    <span>
                        <asp:Literal ID="StrokesLiteral" runat="server" /></span>
                    <span>
                        <asp:Literal ID="RoundsCountLiteral5" runat="server" />
                        senaste rundorna</span>
                    <span>
                        <asp:Literal ID="LatestBruttoavgLiteral" runat="server" /></span>
                </div>

                <div class="statBox">
                    <div class="statBoxHeader">
                        <h3>Pliktslag</h3>
                        <p>
                            <asp:Literal ID="PenaltiesavgLiteral" runat="server" />
                            / runda
                        </p>
                    </div>
                    <span>Antal plikt totalt</span>
                    <span>
                        <asp:Literal ID="PenaltiesLiteral" runat="server" /></span>
                    <span>
                        <asp:Literal ID="RoundsCountLiteral4" runat="server" />
                        senaste rundorna</span>
                    <span>
                        <asp:Literal ID="LatestPenaltiesavgLiteral" runat="server" />
                        / runda</span>
                </div>

                <div class="statBox">
                    <div class="statBoxHeader">
                        <h3>Fairwayträffar</h3>
                        <p>
                            <asp:Literal ID="FIRproLiteral" runat="server" />
                        </p>
                    </div>
                    <span>Antal</span>
                    <span>
                        <asp:Literal ID="FIRLiteral" runat="server" /></span>
                    <span>
                        <asp:Literal ID="RoundsCountLiteral2" runat="server" />
                        senaste rundorna</span>
                    <span>
                        <asp:Literal ID="LatestFIRproLiteral" runat="server" /></span>
                </div>

                <div class="statBox">
                    <div class="statBoxHeader">
                        <h3>Greenträffar</h3>
                        <p>
                            <asp:Literal ID="GIRproLiteral" runat="server" />
                        </p>
                    </div>
                    <span>Antal</span>
                    <span>
                        <asp:Literal ID="GIRLiteral" runat="server" /></span>
                    <span>Snitt/runda</span>
                    <span>
                        <asp:Literal ID="GIRavgLiteral" runat="server" /></span>
                    <span>
                        <asp:Literal ID="RoundsCountLiteral1" runat="server" />
                        senaste rundorna</span>
                    <span>
                        <asp:Literal ID="LatestGIRpro" runat="server" /></span>
                </div>

                <div class="statBox">
                    <div class="statBoxHeader">
                        <h3>Puttar</h3>
                        <p>
                            <asp:Literal ID="PuttsHoleLiteral" runat="server" />
                            / hål
                        </p>
                    </div>
                    <span>Antal</span>
                    <span>
                        <asp:Literal ID="PuttsLiteral" runat="server" /></span>
                    <span>Snitt / Runda</span>
                    <span>
                        <asp:Literal ID="PuttsRoundLiteral" runat="server" /></span>
                    <span>
                        <asp:Literal ID="RoundsCountLiteral3" runat="server" />
                        senaste rundorna</span>
                    <span>
                        <asp:Literal ID="LatestPuttsavgLiteral" runat="server" />
                        / hål</span>
                </div>
                    </div>

            </form>
        </div>
        <!-- content -->

        <footer>
            <p>Nils-Jakob Olsson / no222bd / WP2012 Distans</p>
        </footer>
    </div>
    <!-- container -->
</body>
</html>
