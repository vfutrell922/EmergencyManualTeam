#pragma checksum "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "cca43b252a4b091c9d49b3d5b7de9d7412a9f625"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Protocols_Index), @"mvc.1.0.view", @"/Views/Protocols/Index.cshtml")]
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
#line 1 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\_ViewImports.cshtml"
using EMT_WebPortal;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\_ViewImports.cshtml"
using EMT_WebPortal.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"cca43b252a4b091c9d49b3d5b7de9d7412a9f625", @"/Views/Protocols/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"288da7131b732b3e8f9d9c3b5a80f2b038bb7d93", @"/Views/_ViewImports.cshtml")]
    public class Views_Protocols_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<IEnumerable<EMT_WebPortal.Models.Protocol>>
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-action", "Create", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_1 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-action", "Details", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_2 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-action", "Edit", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_3 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-action", "Delete", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
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
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral(@"<!--
    Author: Vincent Futrell
    Date Last Modified: 04/12/2021
    Description: This is the view page that lists all of the protocols existing in the database. This page
    contains razor code to display certain data and depending upon the role of the current user will or will
    not display the links to the create, edit, and delete pages.
-->
");
            WriteLiteral("\r\n");
#nullable restore
#line 10 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
  
    ViewData["Title"] = "Index";

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n<h1>Index</h1>\r\n\r\n<p>\r\n");
#nullable restore
#line 17 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
     if (User.IsInRole("Administrator") || User.IsInRole("WebMaster"))
    {

#line default
#line hidden
#nullable disable
            WriteLiteral("        ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("a", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "cca43b252a4b091c9d49b3d5b7de9d7412a9f6255495", async() => {
                WriteLiteral("Create New");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.Action = (string)__tagHelperAttribute_0.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_0);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n");
#nullable restore
#line 20 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
    }

#line default
#line hidden
#nullable disable
            WriteLiteral("</p>\r\n<table class=\"table\">\r\n    <thead>\r\n        <tr>\r\n            <th>\r\n                ");
#nullable restore
#line 26 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayNameFor(model => model.Name));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 29 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayNameFor(model => model.Certification));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 32 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayNameFor(model => model.PatientType));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 35 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayNameFor(model => model.HasAssociatedMedication));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 38 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayNameFor(model => model.OtherInformation));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 41 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayNameFor(model => model.TreatmentPlan));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 44 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayNameFor(model => model.Guideline));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th></th>\r\n        </tr>\r\n    </thead>\r\n    <tbody>\r\n");
#nullable restore
#line 50 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
 foreach (var item in Model)
{



#line default
#line hidden
#nullable disable
            WriteLiteral("        <tr>\r\n            <td>\r\n                ");
#nullable restore
#line 56 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayFor(modelItem => item.Name));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </td>\r\n            <td>\r\n                ");
#nullable restore
#line 59 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayFor(modelItem => item.Certification));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </td>\r\n            <td>\r\n                ");
#nullable restore
#line 62 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayFor(modelItem => item.PatientType));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </td>\r\n            <td>\r\n");
#nullable restore
#line 65 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                  if (item.HasAssociatedMedication)
                    {
                        string displayText = "Yes";
                        

#line default
#line hidden
#nullable disable
#nullable restore
#line 68 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                   Write(Html.DisplayFor(modelItem => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 68 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                                                                  
                    }
                    else 
                    {
                        string displayText = "No";
                        

#line default
#line hidden
#nullable disable
#nullable restore
#line 73 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                   Write(Html.DisplayFor(modelItem => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 73 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                                                                  
                    }
                  

#line default
#line hidden
#nullable disable
            WriteLiteral("            </td>\r\n            <td>\r\n");
#nullable restore
#line 78 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                  if (item.OtherInformation != null)
                    {
                        string displayText = "";
                        if (item.OtherInformation.Length < 100) { displayText = item.OtherInformation.ToString(); }
                        else { displayText = item.OtherInformation.ToString().Substring(0, 99) + " ..."; }
                        

#line default
#line hidden
#nullable disable
#nullable restore
#line 83 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                   Write(Html.DisplayFor(modelItem => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 83 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                                                                  
                    }
                    else {
                        string displayText = "No Extra Information.";
                        

#line default
#line hidden
#nullable disable
#nullable restore
#line 87 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                   Write(Html.DisplayFor(modelItem => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 87 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                                                                   }
                

#line default
#line hidden
#nullable disable
            WriteLiteral("            </td>\r\n            <td>\r\n");
#nullable restore
#line 91 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                  if (item.TreatmentPlan != null)
                    {
                        string displayText = "";
                        if (item.TreatmentPlan.Length < 100) { displayText = item.TreatmentPlan.ToString(); }
                        else { displayText = item.TreatmentPlan.ToString().Substring(0, 99) + " ..."; }
                        

#line default
#line hidden
#nullable disable
#nullable restore
#line 96 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                   Write(Html.DisplayFor(modelItem => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 96 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                                                                  
                    }
                    else {
                        string displayText = "No treatment plan has been entered for this protocol.";
                        

#line default
#line hidden
#nullable disable
#nullable restore
#line 100 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                   Write(Html.DisplayFor(modelItem => displayText));

#line default
#line hidden
#nullable disable
#nullable restore
#line 100 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                                                                  
                    }

                

#line default
#line hidden
#nullable disable
            WriteLiteral("            </td>\r\n            <td>\r\n                ");
#nullable restore
#line 106 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
           Write(Html.DisplayFor(modelItem => item.Guideline.Name));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </td>\r\n            <td>\r\n                ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("a", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "cca43b252a4b091c9d49b3d5b7de9d7412a9f62517100", async() => {
                WriteLiteral("Details");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.Action = (string)__tagHelperAttribute_1.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_1);
            if (__Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.RouteValues == null)
            {
                throw new InvalidOperationException(InvalidTagHelperIndexerAssignment("asp-route-id", "Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper", "RouteValues"));
            }
            BeginWriteTagHelperAttribute();
#nullable restore
#line 109 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                                          WriteLiteral(item.ID);

#line default
#line hidden
#nullable disable
            __tagHelperStringValueBuffer = EndWriteTagHelperAttribute();
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.RouteValues["id"] = __tagHelperStringValueBuffer;
            __tagHelperExecutionContext.AddTagHelperAttribute("asp-route-id", __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.RouteValues["id"], global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n");
#nullable restore
#line 110 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                 if (User.IsInRole("Administrator") || User.IsInRole("WebMaster")) 
                { 

#line default
#line hidden
#nullable disable
            WriteLiteral("                    ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("a", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "cca43b252a4b091c9d49b3d5b7de9d7412a9f62519669", async() => {
                WriteLiteral("Edit");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.Action = (string)__tagHelperAttribute_2.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_2);
            if (__Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.RouteValues == null)
            {
                throw new InvalidOperationException(InvalidTagHelperIndexerAssignment("asp-route-id", "Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper", "RouteValues"));
            }
            BeginWriteTagHelperAttribute();
#nullable restore
#line 112 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                                           WriteLiteral(item.ID);

#line default
#line hidden
#nullable disable
            __tagHelperStringValueBuffer = EndWriteTagHelperAttribute();
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.RouteValues["id"] = __tagHelperStringValueBuffer;
            __tagHelperExecutionContext.AddTagHelperAttribute("asp-route-id", __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.RouteValues["id"], global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n                    ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("a", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "cca43b252a4b091c9d49b3d5b7de9d7412a9f62521890", async() => {
                WriteLiteral("Delete");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.Action = (string)__tagHelperAttribute_3.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_3);
            if (__Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.RouteValues == null)
            {
                throw new InvalidOperationException(InvalidTagHelperIndexerAssignment("asp-route-id", "Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper", "RouteValues"));
            }
            BeginWriteTagHelperAttribute();
#nullable restore
#line 113 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                                             WriteLiteral(item.ID);

#line default
#line hidden
#nullable disable
            __tagHelperStringValueBuffer = EndWriteTagHelperAttribute();
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.RouteValues["id"] = __tagHelperStringValueBuffer;
            __tagHelperExecutionContext.AddTagHelperAttribute("asp-route-id", __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.RouteValues["id"], global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n");
#nullable restore
#line 114 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
                }

#line default
#line hidden
#nullable disable
            WriteLiteral("            </td>\r\n        </tr>\r\n");
#nullable restore
#line 117 "C:\Users\sierr\OneDrive\Desktop\Fall 2021\Capstone\EmergencyManualTeam\EMT_WebPortal\EMT_WebPortal\Views\Protocols\Index.cshtml"
}

#line default
#line hidden
#nullable disable
            WriteLiteral("    </tbody>\r\n</table>\r\n");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<IEnumerable<EMT_WebPortal.Models.Protocol>> Html { get; private set; }
    }
}
#pragma warning restore 1591
