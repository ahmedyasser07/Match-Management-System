using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing.Printing;
using System.Reflection.Emit;

namespace milestone3
{
    public partial class clubRepPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            String userName = Request.QueryString["userName"];
            Response.Write("hello " + userName);
            String query = "select c.club_id, c.club_name, c.club_location from club c inner join club_representative r on (c.club_id=r.club_id) where r.username="+"'"+userName+"'";
            
            SqlDataAdapter sqlDA = new SqlDataAdapter(query, conn);
            DataTable tbl = new DataTable();
            sqlDA.Fill(tbl);
            GridView1.DataSource = tbl;
            GridView1.DataBind();




            String query2 = "select * from upcomingMatchesOfClub2('"+userName+"')";

            SqlDataAdapter sqlDA1 = new SqlDataAdapter(query2, conn);
            DataTable tbl1 = new DataTable();
            sqlDA1.Fill(tbl1);
            GridView2.DataSource = tbl1;
            GridView2.DataBind();

            conn.Close();

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DateTime time = DateTime.Parse(TextBox1.Text.ToString());
            Response.Redirect("stadiumsfreeon.aspx?time="+time);
        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String stadium = TextBox2.Text;
            DateTime time = DateTime.Parse(TextBox3.Text.ToString());
            String userName = Request.QueryString["username"].ToString();   
            conn.Open();

            SqlCommand checkRequestinSystem = new SqlCommand("checkRequestinSystem", conn);
            checkRequestinSystem.CommandType = CommandType.StoredProcedure;
            checkRequestinSystem.Parameters.Add(new SqlParameter("@clubRep", userName));
            checkRequestinSystem.Parameters.Add(new SqlParameter("@stadium", stadium));
            checkRequestinSystem.Parameters.Add(new SqlParameter("@start", time));
            SqlParameter check = checkRequestinSystem.Parameters.Add("@check", SqlDbType.Int);
            check.Direction = ParameterDirection.Output;
            checkRequestinSystem.ExecuteNonQuery();

            if (check.Value.ToString() == "1")
            {
                Response.Write("request already added in system");
            }
            else
            {
                SqlCommand addHostRequest2 = new SqlCommand("addHostRequest2", conn);
                addHostRequest2.CommandType = CommandType.StoredProcedure;
                addHostRequest2.Parameters.Add(new SqlParameter("@repusername", userName));
                addHostRequest2.Parameters.Add(new SqlParameter("@stadiumname", stadium));
                addHostRequest2.Parameters.Add(new SqlParameter("@start", time));
                addHostRequest2.ExecuteNonQuery();

                Label1.Text = "request sent or have been sent already";
            }
            conn.Close();
        }
    }
}