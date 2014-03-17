using AndersssonsGolfStat.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AndersssonsGolfStat
{
    public partial class Default : System.Web.UI.Page
    {
        private Service _service;

        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["RoundInsert"] != null)
            {
                ShowMessage(Session["RoundInsert"].ToString());
                Session.Remove("RoundInsert");
            }
        }

        // Hämta lista med banor för att populera drop-down menyn

        public IEnumerable<Course> CoursesListView_GetData()
        {
            try
            {
                return Service.GetCourses();
            }
            catch(Exception ex)
            {
                ModelState.AddModelError(String.Empty, ex);
                return null;
            }
        }

        // Visar update- eller insertformuläret beroende på vilken knapp som klickats på.
        protected void RoundDataListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "New")
            {
              
                InsertRoundDiv.Visible = true;
                

            }
            else if (e.CommandName == "Edit")
            {
                
                UpdateRoundDiv.Visible = true;
                

            }
        }

        // Validerar och skickar sedan nyskapad runda till databasen via en metod i Service-klassen.
        public void InsertFormView_InsertItem(RoundData roundData)
        {
            Session.Remove("Insert");
            if (ModelState.IsValid)
            {
                
                try
                {
                    Service.InsertRoundData(roundData);
                    Session["RoundInsert"] = String.Format("Sparandet av rundan spelad den {0} på {1} lyckades.", roundData.Date.ToShortDateString(), roundData.Name);
                    Response.Redirect("~/");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError(String.Empty, ex);
                }
            }
        }

        // Validerar och skickar uppdaterad runda till databasen via en metod i Service-klassen.

        public void UpdateFormView_UpdateItem(int RoundID)
        {
            try
            {
                var roundData = Service.GetRoundDataByRoundId(RoundID);


                if (roundData == null)
                {
                    ModelState.AddModelError(String.Empty, String.Format("Rundan med ID:et {0} hittades inte i databasen.", RoundID));
                    return;
                }

                if (TryUpdateModel(roundData))
                {
                    Service.UpdateRoundData(roundData);
                    ShowMessage(String.Format("Uppdaterandet av rundan spelad den {0} på {1} lyckades.", roundData.Date.ToShortDateString(), roundData.Name));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(String.Empty, ex);
            }

        }

        // Hämtar en runda från databasen för att fylla fälten i update-formuläret.

        public RoundData UpdateFormView_GetItem([QueryString("RID")]int RoundID)
        {
            try
            {
                return Service.GetRoundDataByRoundId(RoundID);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(String.Empty, ex);
                return null;
            }
        }

        // Tar bort en runda från databasen via en metod i Service-klassen.

        public void UpdateFormView_DeleteItem(int roundid)
        {
            try
            {
                Service.DeleteRound(roundid);
                ShowMessage("Borttagandet av rundan lyckades.");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(String.Empty, ex);
            }
        }

        // Visar meddelande efter lyckad operation

        private void ShowMessage(string msg)
        {
            MessageLiteral.Text = msg;
            MessagePanel.Visible = true;
        }

        // Hämtar alla rundor från databasen för att beräkna statistik samt delar sedan upp listan av objekt för att visas sidvis.

        public IEnumerable<RoundData> RoundDataListView_GetDataPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            var roundCollection = Service.GetRoundData();
            var stats = new Statistics(roundCollection);

            DisplayStatistics(stats);

            return RoundDataPage(roundCollection, maximumRows, startRowIndex, out totalRowCount);
        }

        // Metod för att hämta delar av listan av RoundData
        public IEnumerable<RoundData> RoundDataPage( IEnumerable<RoundData> roundData,int maximumRows, int startRowIndex, out int totalRowCount)
        {
            totalRowCount = roundData.Count();

            return roundData.Skip(startRowIndex).Take(maximumRows);
        }

        // Visar data från klassen Statistics

        public void DisplayStatistics(Statistics stats)
        {
            // Holes & Rounds
            RoundsLiteral.Text = stats.Rounds.ToString();
            HolesLiteral.Text = stats.Holes.ToString();

            // Green in regulation
            GIRproLiteral.Text = stats.GIRpro.ToString("P0");
            GIRLiteral.Text = stats.GIR.ToString() + " av " + stats.Holes.ToString();
            GIRavgLiteral.Text = stats.GIRavg.ToString("F1");
            RoundsCountLiteral1.Text = stats.latestRounds.ToString();
            LatestGIRpro.Text = stats.latestGIRpro.ToString("P0");

            // Fairway in regulation
            FIRproLiteral.Text = stats.FIRpro.ToString("P0");
            FIRLiteral.Text = stats.FIR.ToString() + " av " + stats.Fairways.ToString();
            RoundsCountLiteral2.Text = stats.latestRounds.ToString();
            LatestFIRproLiteral.Text = stats.latestFIRpro.ToString("P0");

            // Putts
            PuttsHoleLiteral.Text = stats.PuttsHole.ToString("F1");
            PuttsLiteral.Text = stats.Putts.ToString();
            PuttsRoundLiteral.Text = stats.PuttsRound.ToString("F1");
            RoundsCountLiteral3.Text = stats.latestRounds.ToString();
            LatestPuttsavgLiteral.Text = stats.latestPuttsavg.ToString("F1");

            // Penalties
            PenaltiesavgLiteral.Text = stats.Penaltiesavg.ToString("F1");
            PenaltiesLiteral.Text = stats.Penalties.ToString();
            RoundsCountLiteral4.Text = stats.latestRounds.ToString();
            LatestPenaltiesavgLiteral.Text = stats.latestPenaltiesavg.ToString("F1");

            // Score & Strokes
            BruttoavgLiteral.Text = stats.Bruttoavg.ToString("F0");
            StrokesLiteral.Text = stats.Strokes.ToString();
            RoundsCountLiteral5.Text = stats.latestRounds.ToString();
            LatestBruttoavgLiteral.Text = stats.latestBruttoavg.ToString("F0");
        }

        protected void InsertFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if(e.CommandName == "Insert")
                InsertRoundDiv.Visible = true;
        }

        protected void UpdateFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Update")
                UpdateRoundDiv.Visible = true;
        }
    }
}