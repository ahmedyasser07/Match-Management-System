<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="milestone3.redirectPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            Login<br />
            <br />
            Username<br />
            <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
            <br />
            Password<br />
            <asp:TextBox ID="TextBox2" runat="server" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>

            <br />
            <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click" />
            <br />
            <br />
            OR<br />
            Register As<br />
            <br />
            <asp:Button ID="sportsManager" runat="server" Text="Sports Association Manager" OnClick="sportsManager_Click" />
            <br />
            <br />
            <asp:Button ID="clubRepresentative" runat="server" Text="Club Representative" OnClick="clubRep_Click" />
            <br />
            <br />
            <asp:Button ID="stadiumManager" runat="server" Text="Stadium Manager" OnClick="stadiumManager_Click" />
            <br />
            <br />
            <asp:Button ID="fan" runat="server" Text="Fan" OnClick="fan_Click" />

        </div>
    </form>
</body>
</html>
