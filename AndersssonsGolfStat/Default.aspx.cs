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

        }

        public IEnumerable<Course> CoursesListView_GetData()
        {
            return Service.GetCourses();
        }

        // ListView
        
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

        // Insert FormView

        public void InsertFormView_InsertItem(RoundData roundData)
        {
            Service.InsertRoundData(roundData);
            ShowMessage("Insert success!");
        }

        // Update FormView

        public void UpdateFormView_UpdateItem(int RoundID)
        {
            var row = Service.GetRoundDataByCourseId(RoundID);

            if (TryUpdateModel(row))
            {
                Service.UpdateRoundData(row);
                ShowMessage("Update success!");
            }
        }

        // Update

        public RoundData UpdateFormView_GetItem([QueryString("RID")]int RoundID)
        {
            return Service.GetRoundDataByCourseId(RoundID);
        }

        // Delete
        public void UpdateFormView_DeleteItem(int roundid)
        {
            Service.DeleteRound(roundid);
            ShowMessage("Delete success!");
        }

        private void ShowMessage(string msg)
        {
            MessageLiteral.Text = msg;
            MessagePanel.Visible = true;
        }

        public IEnumerable<RoundData> RoundDataListView_GetDataPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            var roundCollection = Service.GetRoundData();
            var stats = new Statistics(roundCollection);
            
            DisplayStatistics(stats);
            
            return RoundDataPage(roundCollection, maximumRows, startRowIndex, out totalRowCount);

            //var stats = new Statistics(Service.GetRoundData());
            //DisplayStatistics(stats);
            //return Service.GetRoundDataPageWise(maximumRows, startRowIndex, out totalRowCount);
        }

        public IEnumerable<RoundData> RoundDataPage( IEnumerable<RoundData> roundData,int maximumRows, int startRowIndex, out int totalRowCount)
        {
            totalRowCount = roundData.Count();

            return roundData.Skip(startRowIndex).Take(maximumRows);
            //roundData.Skip(startRowIndex);
            //return roundData.Take(maximumRows);
        }

        // Statistics
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
    }
}