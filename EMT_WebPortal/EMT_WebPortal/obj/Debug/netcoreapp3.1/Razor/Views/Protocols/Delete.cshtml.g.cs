#pragma checksum "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "25bea528edbc098942d4cccfb05508945994e74c"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Protocols_Delete), @"mvc.1.0.view", @"/Views/Protocols/Delete.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\_ViewImports.cshtml"
using EMT_WebPortal;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\_ViewImports.cshtml"
using EMT_WebPortal.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"25bea528edbc098942d4cccfb05508945994e74c", @"/Views/Protocols/Delete.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"288da7131b732b3e8f9d9c3b5a80f2b038bb7d93", @"/Views/_ViewImports.cshtml")]
    public class Views_Protocols_Delete : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<EMT_WebPortal.Models.Protocol>
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("type", "hidden", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_1 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-action", "Index", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_2 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-action", "Delete", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper;
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper;
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.InputTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_InputTagHelper;
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral(@"<!--
    Author: Vincent Futrell
    Date Last Modified: 04/12/2021
    Description: This is the view for the delete page of an individual protocol. This page contains razor
    code to display certain information from the database. Since Authorization has already been performed
    several times to reach this page, all links are displayed.
-->
");
            WriteLiteral("\r\n");
#nullable restore
#line 10 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
  
    ViewData["Title"] = "Delete";

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n<h1>Delete</h1>\r\n\r\n<h3>Are you sure you want to delete this?</h3>\r\n<div>\r\n    <h4>Protocol</h4>\r\n    <hr />\r\n    <dl class=\"row\">\r\n        <dt class = \"col-sm-2\">\r\n            ");
#nullable restore
#line 22 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayNameFor(model => model.Name));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dt>\r\n        <dd class = \"col-sm-10\">\r\n            ");
#nullable restore
#line 25 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayFor(model => model.Name));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class = \"col-sm-2\">\r\n            ");
#nullable restore
#line 28 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayNameFor(model => model.Certification));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dt>\r\n        <dd class = \"col-sm-10\">\r\n            ");
#nullable restore
#line 31 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayFor(model => model.Certification));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class = \"col-sm-2\">\r\n            ");
#nullable restore
#line 34 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayNameFor(model => model.PatientType));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n");
#nullable restore
#line 37 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
              
                int patientType = Model.PatientType;
                if (patientType == 1)
                {
                    string displayText = "All"; 

#line default
#line hidden
#nullable disable
#nullable restore
#line 41 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
                                           Write(Html.DisplayFor(model => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 41 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
                                                                                       }
                else if (patientType == 2)
                {
                    string displayText = "Adult"; 

#line default
#line hidden
#nullable disable
#nullable restore
#line 44 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
                                             Write(Html.DisplayFor(model => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 44 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
                                                                                         }
                else
                {
                    string displayText = "Pediatric"; 

#line default
#line hidden
#nullable disable
#nullable restore
#line 47 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
                                                 Write(Html.DisplayFor(model => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 47 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
                                                                                             }
            

#line default
#line hidden
#nullable disable
            WriteLiteral("        </dd>\r\n        <dt class = \"col-sm-2\">\r\n            ");
#nullable restore
#line 51 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayNameFor(model => model.HasAssociatedMedication));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n");
#nullable restore
#line 54 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
              if (Model.HasAssociatedMedication)
                {
                    string displayText = " : Yes";
                    

#line default
#line hidden
#nullable disable
#nullable restore
#line 57 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
               Write(Html.DisplayFor(model => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 57 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
                                                          
                }
                else
                {
                    string displayText = " : No";
                    

#line default
#line hidden
#nullable disable
#nullable restore
#line 62 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
               Write(Html.DisplayFor(model => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 62 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
                                                          
                }
            

#line default
#line hidden
#nullable disable
            WriteLiteral("        </dd>\r\n        <dt class = \"col-sm-2\">\r\n            ");
#nullable restore
#line 67 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayNameFor(model => model.OtherInformation));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dt>\r\n        <dd class = \"col-sm-10\">\r\n            ");
#nullable restore
#line 70 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayFor(model => model.OtherInformation));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class = \"col-sm-2\">\r\n            ");
#nullable restore
#line 73 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayNameFor(model => model.TreatmentPlan));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dt>\r\n        <dd class = \"col-sm-10\">\r\n            ");
#nullable restore
#line 76 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayFor(model => model.TreatmentPlan));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class = \"col-sm-2\">\r\n            ");
#nullable restore
#line 79 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayNameFor(model => model.Guideline));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dt>\r\n        <dd class = \"col-sm-10\">\r\n            ");
#nullable restore
#line 82 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
       Write(Html.DisplayFor(model => model.Guideline.Name));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd class>\r\n    </dl>\r\n    \r\n    ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("form", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "25bea528edbc098942d4cccfb05508945994e74c13861", async() => {
                WriteLiteral("\r\n        ");
                __tagHelperExecutionContext = __tagHelperScopeManager.Begin("input", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.SelfClosing, "25bea528edbc098942d4cccfb05508945994e74c14128", async() => {
                }
                );
                __Microsoft_AspNetCore_Mvc_TagHelpers_InputTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.InputTagHelper>();
                __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_InputTagHelper);
                __Microsoft_AspNetCore_Mvc_TagHelpers_InputTagHelper.InputTypeName = (string)__tagHelperAttribute_0.Value;
                __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_0);
#nullable restore
#line 87 "C:\Users\vince\source\repos\mollyclare111\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Delete.cshtml"
__Microsoft_AspNetCore_Mvc_TagHelpers_InputTagHelper.For = ModelExpressionProvider.CreateModelExpression(ViewData, __model => __model.ID);

#line default
#line hidden
#nullable disable
                __tagHelperExecutionContext.AddTagHelperAttribute("asp-for", __Microsoft_AspNetCore_Mvc_TagHelpers_InputTagHelper.For, global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
                await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
                if (!__tagHelperExecutionContext.Output.IsContentModified)
                {
                    await __tagHelperExecutionContext.SetOutputContentAsync();
                }
                Write(__tagHelperExecutionContext.Output);
                __tagHelperExecutionContext = __tagHelperScopeManager.End();
                WriteLiteral("\r\n        <input type=\"submit\" value=\"Delete\" class=\"btn btn-danger\" /> |\r\n        ");
                __tagHelperExecutionContext = __tagHelperScopeManager.Begin("a", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "25bea528edbc098942d4cccfb05508945994e74c15955", async() => {
                    WriteLiteral("Back to List");
                }
                );
                __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper>();
                __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper);
                __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.Action = (string)__tagHelperAttribute_1.Value;
                __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_1);
                await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
                if (!__tagHelperExecutionContext.Output.IsContentModified)
                {
                    await __tagHelperExecutionContext.SetOutputContentAsync();
                }
                Write(__tagHelperExecutionContext.Output);
                __tagHelperExecutionContext = __tagHelperScopeManager.End();
                WriteLiteral("\r\n    ");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.Action = (string)__tagHelperAttribute_2.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_2);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n</div>\r\n");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<EMT_WebPortal.Models.Protocol> Html { get; private set; }
    }
}
#pragma warning restore 1591
