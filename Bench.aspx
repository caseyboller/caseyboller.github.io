<%@ Page Title="Bench" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bench.aspx.cs" Inherits="Assignment1.Bench" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPBody" runat="server">

    <div class="container bg-light rounded py-3">
        <div class="row">
            <div class="col-md-6 col-sm-12 my-3">
                <h2 class="text-center">Calculate your Relative Strength</h2>
                <h2 class="pb-3 pt-0 text-center">for Bench Press:</h2>
                <div class="container col-11 offset-0 text-right">
                    <form name="benchForm" runat="server">
                        <div class="form-group row">
                            <div class="col-md-3 py-2">
                                <label class="text-right" for="Gender">Gender:</label>

                            </div>
                            <div class="col">
                                <select name="Gender" id="Gender" class="form-control">
                                    <option value="">Gender...</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            <div class="col-1 pl-0 py-2">
                                <label for="Age">Age:</label>
                            </div>
                            <div class="col">
                                <select name="Age" id="Age" class="form-control">
                                    <option value="">Age range...</option>
                                    <option value="age14to17">14-17</option>
                                    <option value="age18to23">18-23</option>
                                    <option value="age24to39">24-39</option>
                                    <option value="age40to49">40-49</option>
                                    <option value="age50to59">50-59</option>
                                    <option value="age60to69">60-69</option>
                                    <option value="age70to79">70-79</option>
                                    <option value="age80to89">80-89</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group row">
                            <div class="col-3 py-2">
                                <label for="Bodyweight">Bodyweight</label>
                            </div>
                            <div class="col-5 pr-0">
                                <input type="number" id="Bodyweight" name="Bodyweight" class="form-control pr-0" min="0" required/>
                            </div>
                            <div class="col pl-2">
                                <select name="BWUnit" class="form-control ">
                                    <option value="kg" selected>kg</option>
                                    <option value="lbs" disabled>lbs</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group row">
                            <div class="col-md-3 py-2">
                                <label for="Exercise">Exercise:</label>
                            </div>
                            <div class="col-md">
                                <select name="Exercise" id="Exercise" class="form-control" required>
                                    <option value="" disabled>Select exercise...</option>
                                    <option value="bench">Bench Press</option>
                                    <option value="deadlift" disabled>Deadlift</option>
                                    <option value="squat" disabled>Squat</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group row">
                            <div class="col-3 py-2">
                                <label for="Lift">Lift:</label>
                            </div>
                            <div class="col-5 pr-0">
                                <input type="number" id="Lift" name="Lift" class="form-control pr-0" min="0" required/>
                            </div>
                            <div class="col pl-2">
                                <select name="LiftUnit" class="form-control ">
                                    <option value="kg" selected>kg</option>
                                    <option value="lbs" disabled>lbs</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group row">
                            <div class="col-3 py-2">
                                <label for="Repetitions">Repetitions:</label>
                            </div>
                            <div class="col-3">
                                <input type="number" id="Repetitions" name="Reps" class="form-control pr-0" min="1" max="30" value="1" required />
                            </div>
                        </div>

                        <div id="calcButtonDiv" style="opacity:0.7">
                            <div class="form-group row">
                                <div class="col">
                                    <asp:Button runat="server" class="btn btn-success btn-lg" OnClick="Calculate_Button" ID="calcButton" Text="Calculate Strength" />
                                </div>
                            </div>

                        </div>

                    </form>
                </div>
            </div>
            <div class="container col-md-6 col-sm-12 py-3">
                <p>Strength Calculator calculates your performance in the compound exercises bench press, deadlift and squat.</p>
                <p>Enter your one-rep max and we will rank you against other lifters at your bodyweight. </p>
                <p>If you don't know your current one-rep max, change the number of repetitions and enter your most recent workout set where you went to failure.</p>
                <p>You can compare your scores against heavier or lighter friends, and across genders.</p>
                <p>← Start now!</p>
            </div>
        </div>
    </div>
    <div id="ormHide" style="opacity: 0.0">
        <div class="container bg-light rounded my-3" visible="false" id="oneRepMaxContainer" runat="server">
            <div class="row">
                <div class="col-md-6 col-sm-12 py-3">
                    <h5>We estimate that your one-rep max is
                <asp:Label ID="oneRepMaxLabel" runat="server" />
                    </h5>
                    <button class="btn" id="myBtn">How is this calculated?</button>
                    <div class="container">
                        <p id="showMe"></p>
                    </div>

                    <p>
                        <% currentUser = CreateUserFromForm(); %>
                    </p>
                </div>
                <div class="col-md-6 col-sm-12  py-3">
                    <h4>The Standards for a Bodyweight of <%= currentUser.bodyweight %> <%= currentUser.BWUnit %></h4>
                    <p>(2 closest weights shown)</p>
                    <asp:SqlDataSource ID="MaleBenchStandards" runat="server" ConnectionString="<%$ ConnectionStrings:StandardsConnectionString %>"
                        OnSelecting="StrengthStandards_Selecting" SelectCommand="SELECT TOP 2 * FROM MaleBenchStandardKg ORDER BY ABS([Bodyweight] - @Bodyweight)">
                        <SelectParameters>
                            <asp:FormParameter FormField="Bodyweight" Name="Bodyweight" Type="Int16" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Repeater ID="BenchStandards" runat="server" DataSourceID="MaleBenchStandards">
                        <HeaderTemplate>
                            <div class="row border-bottom border-dark">
                                <div class="col-md mx-1 my-1 standard">BW</div>
                                <div class="col-md mx-1 my-1 standard">Beg.</div>
                                <div class="col-md mx-1 my-1 standard">Nov.</div>
                                <div class="col-md mx-1 my-1 standard">Intermed.</div>
                                <div class="col-md mx-1 my-1 standard">Adv.</div>
                                <div class="col-md mx-1 my-1 standard">Elite</div>
                            </div>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="row border-bottom">
                                <div class="col-md mx-1 my-1 standard border-right border-dark">
                                    <h6 class="text-center my-2"><%# Eval("Bodyweight") %></h6>
                                </div>
                                <div class="col-md mx-1 my-1 border-right standard">
                                    <h6 class="text-center my-2"><%# FormatStandard(Eval("Beginner"), currentUser) %></h6>
                                </div>
                                <div class="col-md mx-1 my-1 border-right standard">
                                    <h6 class="text-center my-2"><%# FormatStandard(Eval("Novice"), currentUser) %></h6>
                                </div>
                                <div class="col-md mx-1 my-1 border-right standard">
                                    <h6 class="text-center my-2"><%# FormatStandard(Eval("Intermediate"), currentUser) %></h6>
                                </div>
                                <div class="col-md mx-1 my-1 border-right standard">
                                    <h6 class="text-center my-2"><%# FormatStandard(Eval("Advanced"), currentUser) %></h6>
                                </div>
                                <div class="col-md mx-1 my-1 border-right standard">
                                    <h6 class="text-center my-2"><%# FormatStandard(Eval("Elite"), currentUser) %></h6>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>


        </div>
    </div>
    <script>
        var myBtn = document.getElementById("myBtn");
        myBtn.addEventListener("click", showExplanation);
        function showExplanation() {
            showMeContainer = document.getElementById("showMe");
            showMeContainer.innerHTML = "Your one-rep max is the max weight you can lift for a single repetition for a given exercise. This is calculated based on the amount of repetitions you can do for a given weight.";
            showMeContainer.addEventListener("mouseover", function () { showMeContainer.style.fontSize = "130%"; });
            showMeContainer.addEventListener("mouseout", function () { showMeContainer.style.fontSize = "100%"; });
        }
    </script>
    <script>
        document.getElementById("bpressNav").classList.add("active");
    </script>
    <script>
        $(document).ready(function () {
            $("#ormHide").animate({ opacity: "1" });
        });
        $("#myBtn").click(function () {
            $("#myBtn").animate({ width: "200px" }, 100, "swing");
        });
        $("#calcButtonDiv").hover(function () {
            $("#calcButtonDiv").animate({ opacity: "1" });
        }, function () {
            $("#calcButtonDiv").animate({ opacity: "0.7" });
        });
    </script>
</asp:Content>
