using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3
{
    public partial class systemAdminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox7_TextChanged(object sender, EventArgs e)
        {

        }

        protected void clubLoc_TextChanged(object sender, EventArgs e)
        {

        }

        protected void addClub_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String clubName = clubNameforADD.Text;
            String clubLocation = clubLoc.Text;

            conn.Open();

            SqlCommand checkIfClubInSystem = new SqlCommand("checkIfClubInSystem", conn);
            checkIfClubInSystem.CommandType = CommandType.StoredProcedure;
            checkIfClubInSystem.Parameters.Add(new SqlParameter("@clubname", clubName));
            SqlParameter checkBit = checkIfClubInSystem.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            checkIfClubInSystem.ExecuteNonQuery();

            if (checkBit.Value.ToString() == "1")
            {
                Response.Write("club already in system");
            }
            else
            {
                SqlCommand addClubProc = new SqlCommand("addClub", conn);
                addClubProc.CommandType = CommandType.StoredProcedure;
                addClubProc.Parameters.Add(new SqlParameter("@name", clubName));
                addClubProc.Parameters.Add(new SqlParameter("@location", clubLocation));
                addClubProc.ExecuteNonQuery();
            }
            conn.Close();
        }

        protected void clubNameFordelete_TextChanged(object sender, EventArgs e)
        {

        }

        protected void deleteClub_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String clubName = clubNameFordelete.Text;

            conn.Open();

            SqlCommand checkIfClubInSystem = new SqlCommand("checkIfClubInSystem", conn);
            checkIfClubInSystem.CommandType = CommandType.StoredProcedure;
            checkIfClubInSystem.Parameters.Add(new SqlParameter("@clubname", clubName));
            SqlParameter checkBit = checkIfClubInSystem.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            checkIfClubInSystem.ExecuteNonQuery();

            if (checkBit.Value.ToString() == "0")
            {
                Response.Write("club not found in system to be deleted");
            }
            else
            {
                SqlCommand deleteClub = new SqlCommand("deleteClub", conn);
                deleteClub.CommandType = CommandType.StoredProcedure;
                deleteClub.Parameters.Add(new SqlParameter("@name", clubName));
                deleteClub.ExecuteNonQuery();

            }

            conn.Close();

        }

        protected void stadNameforADD_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Location_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Capacity_TextChanged(object sender, EventArgs e)
        {

        }

        protected void addStad_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String stadName = stadNameforADD.Text;
            String loc = Location.Text;
            int capacity = Convert.ToInt32(Capacity.Text);
            conn.Open();


            SqlCommand checkIfStadiumInSystem = new SqlCommand("checkIfStadiumInSystem", conn);
            checkIfStadiumInSystem.CommandType = CommandType.StoredProcedure;
            checkIfStadiumInSystem.Parameters.Add(new SqlParameter("@stadiumname", stadName));
            SqlParameter checkBit = checkIfStadiumInSystem.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            checkIfStadiumInSystem.ExecuteNonQuery();


            if (checkBit.Value.ToString() == "1")
            {
                Response.Write("stadium already in system");
            }
            else
            {
                SqlCommand addStadium = new SqlCommand("addStadium", conn);
                addStadium.CommandType = CommandType.StoredProcedure;
                addStadium.Parameters.Add(new SqlParameter("@name", stadName));
                addStadium.Parameters.Add(new SqlParameter("@location", loc));
                addStadium.Parameters.Add(new SqlParameter("@cap", capacity));
                addStadium.ExecuteNonQuery();
            }

             
            conn.Close();
        }

        protected void deleteStad_Click(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String stad = stadName.Text;

            conn.Open();

            SqlCommand checkIfStadiumInSystem = new SqlCommand("checkIfStadiumInSystem", conn);
            checkIfStadiumInSystem.CommandType = CommandType.StoredProcedure;
            checkIfStadiumInSystem.Parameters.Add(new SqlParameter("@stadiumname", stad));
            SqlParameter checkBit = checkIfStadiumInSystem.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            checkIfStadiumInSystem.ExecuteNonQuery();


            if (checkBit.Value.ToString() == "0")
            {
                Response.Write("stadium not in system to be delted");
            }
            else
            {
                SqlCommand deleteStad = new SqlCommand("deleteStadium", conn);
                deleteStad.CommandType = CommandType.StoredProcedure;
                deleteStad.Parameters.Add(new SqlParameter("@name", stad));
                deleteStad.ExecuteNonQuery();
                Response.Write("stadium delted");

            }

            conn.Close();
        }

        protected void fanID_TextChanged(object sender, EventArgs e)
        {

        }

        protected void blockButton_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String fanNO = fanID.Text;

            SqlCommand blockfan = new SqlCommand("blockFan", conn);
            blockfan.CommandType = CommandType.StoredProcedure;
            blockfan.Parameters.Add(new SqlParameter("@id", fanNO));

            conn.Open();
            blockfan.ExecuteNonQuery();
            conn.Close();
        }
    }
}