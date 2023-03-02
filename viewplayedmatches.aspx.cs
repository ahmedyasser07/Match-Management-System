using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3
{
    public partial class viewplayedmatches : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlDataAdapter sqlDA = new SqlDataAdapter("select * from allPlayedMatchesOfAllClubs", conn);
            DataTable tbl = new DataTable();
            sqlDA.Fill(tbl);
            GridView1.DataSource = tbl;
            GridView1.DataBind();

            conn.Close();
        }
    }
}