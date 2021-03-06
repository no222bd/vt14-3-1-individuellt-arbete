﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model
{
    // Klass innehållandes statistik över spelade rundor
    public class Statistics
    {
        // Ingen validering p.g.a. ingen data matas in av användaren
        public readonly int latestRounds = 3;

        // Egenskaper som initialiseras med hjälp av ett RoundData objekt
        public int Rounds { get; set; }

        public int GIR { get; set; }
        public int latestGIR { get; set; }
        
        public int FIR { get; set; }
        public int latestFIR { get; set; }
        public int Fairways { get; set; }
        public int latestFairways { get; set; }

        public int Putts { get; set; }
        public int latestPutts { get; set; }

        public int Penalties { get; set; }
        public int latestPenalties { get; set; }
        
        public int Strokes { get; set; }
        public int Brutto { get; set; }
        public int latestBrutto { get; set; }

        // Beräknade egenskaper
        public int Holes { get { return Rounds * 18; } }
        public float GIRpro { get { return (float)GIR / Holes; } }
        public float GIRavg { get { return (float)GIR / Rounds; } }
        public float latestGIRpro { get { return (float)latestGIR / (latestRounds * 18); } }

        public float FIRpro { get { return (float)FIR / Fairways ;} }
        public float latestFIRpro { get { return (float)latestFIR / latestFairways; } }

        public float PuttsHole { get { return (float)Putts / Holes;} }
        public float PuttsRound { get { return (float)Putts / Rounds; } }
        public float latestPuttsavg { get { return (float)latestPutts / (latestRounds * 18); } }

        public float Penaltiesavg { get { return (float)Penalties / Rounds; } }
        public float latestPenaltiesavg { get { return (float)latestPenalties / latestRounds; } }

        public float Bruttoavg { get { return (float)Brutto / Rounds ;} }
        public float latestBruttoavg { get { return (float)latestBrutto / latestRounds; } }

        public Statistics(IEnumerable<RoundData> roundData)
        {
            Initialize(roundData);
        }

        private void Initialize(IEnumerable<RoundData> roundData)
        {
            // Sorterar listans innehåll på datum i fallande ordning
            var sortedData = roundData.OrderByDescending(c => c.Date);

            // Sätter värdet för antalet spelade rundor
            Rounds = sortedData.Count();

            // Itererar igenom och addera värde till respektive egenskap
            foreach (var row in sortedData)
            {
                GIR += row.GIR;
                FIR += row.FIR;
                Fairways += row.Fairways;
                Putts += row.Putts;
                Penalties += row.Penalties;
                Strokes += row.Strokes;
                Brutto += row.Brutto;
            }

            // Skapa lista innehållande endast de senaste rundorna
            var sortedDataTop = sortedData.Take(latestRounds);

            //Itererar igenom och addera värde till respektive egenskap
            foreach (var row in sortedDataTop)
            {
                latestGIR += row.GIR;
                latestFIR += row.FIR;
                latestFairways += row.Fairways;
                latestPutts += row.Putts;
                latestPenalties += row.Penalties;
                latestBrutto += row.Brutto;
            }
        }
    }
}