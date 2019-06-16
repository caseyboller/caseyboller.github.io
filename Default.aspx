<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Default.aspx.cs" Inherits="Assignment1.Default" %>


<asp:Content ID="Content1" ContentPlaceHolderID="CPHead" runat="server">
    <style>

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPBody" runat="server">
    <div class="container bg-transparent rounded py-3">
        <h1 class="text-light text-center">Welcome to Strength Calculator!</h1>
        <h4 class="text-light text-center">Choose an exercise:</h4>
        <div class="row">
            <div class="col">
                <a href="Bench.aspx" class="selector-text-box">
                    <img src="Images/bench.png" alt="benchpress button" class="selector-button center " />
                    <p>Bench Press</p>
                </a>
            </div>
            <div class="col mx-2">
                <a href="Home/MvcDeadlift" class="selector-text-box">
                    <img src="Images/dead.png" alt="deadlifts button" class="selector-button center" />
                    <p>Deadlift</p>
                </a>
            </div>
            <div class="col">
                <a href="Management/Squat.aspx" class="selector-text-box">
                    <img src="Images/squat.png" alt="squats button" class="center selector-button" />
                    <p>Squat</p>
                </a>
            </div>
        </div>
    </div>
</asp:Content>
