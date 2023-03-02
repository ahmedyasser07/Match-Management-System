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
    public partial class fanLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = TextBox1.Text;
            String userName = usernameF.Text;
            String passWord = passwordF.Text;
            String id = TextBox2.Text.ToString();
            String phone = TextBox3.Text.ToString();
            DateTime birth =DateTime.Parse(TextBox4.Text.ToString());
            String address = TextBox5.Text;
            conn.Open();

            SqlCommand checkUsername = new SqlCommand("checkUsername", conn);
            checkUsername.CommandType = CommandType.StoredProcedure;
            checkUsername.Parameters.Add(new SqlParameter("@username", userName));
            SqlParameter checkBit = checkUsername.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            checkUsername.ExecuteNonQuery();

            if (checkBit.Value.ToString() == "1")
            {
                Response.Write("username already in use, try logging in");

            }
            else
            {
                SqlCommand addFan = new SqlCommand("addFan", conn);
                addFan.CommandType = CommandType.StoredProcedure;
                addFan.Parameters.Add(new SqlParameter("@name", name));
                addFan.Parameters.Add(new SqlParameter("@username", userName));
                addFan.Parameters.Add(new SqlParameter("@password", passWord));
                addFan.Parameters.Add(new SqlParameter("@nationalID", id));
                addFan.Parameters.Add(new SqlParameter("@birthdate", birth));
                addFan.Parameters.Add(new SqlParameter("@address", address));
                addFan.Parameters.Add(new SqlParameter("@phone", phone));
                addFan.ExecuteNonQuery();
                Response.Redirect("fanPage.aspx?id="+id);

            }

            conn.Close();
        }

        protected void username_TextChanged(object sender, EventArgs e)
        {

        }

        protected void password_TextChanged(object sender, EventArgs e)
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

        protected void TextBox5_TextChanged(object sender, EventArgs e)
        {

        }
    }
}