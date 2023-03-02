using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace milestone3
{
    public partial class sportsManagerPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox4_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String host = TextBox1.Text;
            String guest = TextBox2.Text;
            DateTime start = DateTime.Parse(TextBox3.Text);
            DateTime end = DateTime.Parse(TextBox4.Text);
            conn.Open();

            SqlCommand checkMatchinSystem = new SqlCommand("checkMatchinSystem", conn);
            checkMatchinSystem.CommandType = CommandType.StoredProcedure;
            checkMatchinSystem.Parameters.Add(new SqlParameter("@host", host));
            checkMatchinSystem.Parameters.Add(new SqlParameter("@guest", guest));
            checkMatchinSystem.Parameters.Add(new SqlParameter("@start", start));
            SqlParameter check = checkMatchinSystem.Parameters.Add("@check", SqlDbType.Int);
            check.Direction = ParameterDirection.Output;
            checkMatchinSystem.ExecuteNonQuery();

            if (check.Value.ToString() == "1")
            {
                Response.Write("match already added in system");
            }
            else {
                SqlCommand addNewMatch = new SqlCommand("addNewMatch", conn);
                addNewMatch.CommandType = CommandType.StoredProcedure;
                addNewMatch.Parameters.Add(new SqlParameter("@hostName", host));
                addNewMatch.Parameters.Add(new SqlParameter("@guestName", guest));
                addNewMatch.Parameters.Add(new SqlParameter("@start", start));
                addNewMatch.Parameters.Add(new SqlParameter("@end", end));
                
                addNewMatch.ExecuteNonQuery();
               
                Response.Write("match added");
            }


            conn.Close();
        }

        protected void TextBox5_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox6_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox7_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox8_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String host = TextBox5.Text;
            String guest = TextBox6.Text;
            DateTime start = DateTime.Parse(TextBox7.Text);
            DateTime end = DateTime.Parse(TextBox8.Text);

            SqlCommand deleteMatch = new SqlCommand("deleteMatch", conn);
            deleteMatch.CommandType = CommandType.StoredProcedure;
            deleteMatch.Parameters.Add(new SqlParameter("@host", host));
            deleteMatch.Parameters.Add(new SqlParameter("@guest", guest));
            deleteMatch.Parameters.Add(new SqlParameter("@start", start));
            deleteMatch.Parameters.Add(new SqlParameter("@end", end));

            conn.Open();
            deleteMatch.ExecuteNonQuery();
            conn.Close();
            Response.Write("match deleted or has been already delted before");

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewupcomingmatches.aspx");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewplayedmatches.aspx");
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Response.Redirect("clubsnevermatched.aspx");

        }
    }
}