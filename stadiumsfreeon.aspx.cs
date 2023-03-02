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
    public partial class stadiumsfreeon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            String time = Request.QueryString["time"];
            Response.Write("stadiums that are available starting from  " + time);
            String query = "select * from viewAvailableStadiumsOn ('" + time + "')";

            SqlDataAdapter sqlDA = new SqlDataAdapter(query, conn);
            DataTable tbl = new DataTable();
            sqlDA.Fill(tbl);
            GridView1.DataSource = tbl;
            GridView1.DataBind();
        }
    }
}