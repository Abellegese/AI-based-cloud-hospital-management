using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using hms.db.access;

namespace hms.library.classes
{
    public class Card : Patient, ICard
    {
        public Card() { }
        public void RegisterPatient() { }
    }
}