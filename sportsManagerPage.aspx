<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sportsManagerPage.aspx.cs" Inherits="milestone3.sportsManagerPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Sports Association Manager Page<br />
            <br />
            Add a New Match<br />
            Host Club<br />
            <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
            <br />
            Guest Club<br />
            <asp:TextBox ID="TextBox2" runat="server" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
            <br />
            Start Time<br />
            <asp:TextBox ID="TextBox3" type="datetime-local" runat="server" OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
            <br />
            End Time<br />
            <asp:TextBox ID="TextBox4" type="datetime-local" runat="server" OnTextChanged="TextBox4_TextChanged"></asp:TextBox>
            <br />
            Note: date - time format = <span style="color: rgb(32, 33, 36); font-family: arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">YYYY-MM-DD hh:mm:ss
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
            <br />
            <br />
                Delete Match<br />
            Host Club<br />
            <asp:TextBox ID="TextBox5" runat="server" OnTextChanged="TextBox5_TextChanged"></asp:TextBox>
            <br />
            Guest Club<br />
            <asp:TextBox ID="TextBox6" runat="server" OnTextChanged="TextBox6_TextChanged"></asp:TextBox>
            <br />
            Start Time<br />
            <asp:TextBox ID="TextBox7" type="datetime-local" runat="server" OnTextChanged="TextBox7_TextChanged"></asp:TextBox>
            <br />
            End Time<br />
            <asp:TextBox ID="TextBox8" type="datetime-local" runat="server" OnTextChanged="TextBox8_TextChanged"></asp:TextBox>
            <br />
            Note: date - time format = <span style="color: rgb(32, 33, 36); font-family: arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">YYYY-MM-DD hh:mm:ss
           </span>
                <br />
            <br />
            <asp:Button ID="Button2" runat="server" Text="Delete" OnClick="Button2_Click" />
            <br />
            <br />
            View All Upcoming Matches<br />
            <asp:Button ID="Button3" runat="server" Text="View" OnClick="Button3_Click" />
            <br />
            <br />
            View All Played Matches<br />
            <asp:Button ID="Button4" runat="server" Text="View" OnClick="Button4_Click" />
            <br />
            <br />
            View Clubs Who never played Each other<br />
            <asp:Button ID="Button5" runat="server" Text="View" OnClick="Button5_Click" />
            <br />
            
            <br />
            
        </div>
    </form>
</body>
</html>
