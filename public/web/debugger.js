/* Copyright 2012 Mozilla Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
"use strict"
var FontInspector=function(){function e(){for(var e=document.querySelectorAll("div["+o+"]"),t=0,n=e.length;t<n;++t){e[t].className=""}}function t(){for(var e=document.querySelectorAll("div["+o+"]"),t=0,n=e.length;t<n;++t){e[t].className="debuggerHideText"}}function n(e,t){for(var n=document.querySelectorAll("div["+o+"="+e+"]"),a=0,r=n.length;a<r;++a){n[a].className=t?"debuggerShowText":"debuggerHideText"}}function a(e){if(e.target.dataset.fontName&&"DIV"===e.target.tagName.toUpperCase())for(var t=e.target.dataset.fontName,a=document.getElementsByTagName("input"),r=0;r<a.length;++r){var i=a[r]
i.dataset.fontName===t&&(i.checked=!i.checked,n(t,i.checked),i.scrollIntoView())}}var r,i=!1,o="data-font-name"
return{id:"FontInspector",name:"Font Inspector",panel:null,manager:null,init:function(e){var n=this.panel
n.setAttribute("style","padding: 5px;")
var a=document.createElement("button")
a.addEventListener("click",t),a.textContent="Refresh",n.appendChild(a),r=document.createElement("div"),n.appendChild(r)},cleanup:function(){r.textContent=""},enabled:!1,get active(){return i},set active(n){i=n,i?(document.body.addEventListener("click",a,!0),t()):(document.body.removeEventListener("click",a,!0),e())},fontAdded:function(e,a){var i=function(e,t){for(var n=document.createElement("table"),a=0;a<t.length;a++){var r=document.createElement("tr"),i=document.createElement("td")
i.textContent=t[a],r.appendChild(i)
var o=document.createElement("td")
o.textContent=e[t[a]].toString(),r.appendChild(o),n.appendChild(r)}return n}(e,["name","type"]),o=e.loadedName,d=document.createElement("div"),l=document.createElement("span")
l.textContent=o
var s=document.createElement("a")
a?(a=/url\(['"]?([^\)"']+)/.exec(a),s.href=a[1]):e.data&&(a=URL.createObjectURL(new Blob([e.data],{type:e.mimeType})),s.href=a),s.textContent="Download"
var c=document.createElement("a")
c.href="",c.textContent="Log",c.addEventListener("click",function(t){t.preventDefault(),console.log(e)})
var p=document.createElement("input")
p.setAttribute("type","checkbox"),p.dataset.fontName=o,p.addEventListener("click",function(e,t){return function(){n(t,e.checked)}}(p,o)),d.appendChild(p),d.appendChild(l),d.appendChild(document.createTextNode(" ")),d.appendChild(s),d.appendChild(document.createTextNode(" ")),d.appendChild(c),d.appendChild(i),r.appendChild(d),setTimeout(function(){this.active&&t()}.bind(this),2e3)}}}(),opMap,StepperManager=function(){var e=[],t=null,n=null,a=null,r=Object.create(null)
return{id:"Stepper",name:"Stepper",panel:null,manager:null,init:function(e){var i=this
this.panel.setAttribute("style","padding: 5px;"),n=document.createElement("div"),a=document.createElement("select"),a.addEventListener("change",function(e){i.selectStepper(this.value)}),n.appendChild(a),t=document.createElement("div"),this.panel.appendChild(n),this.panel.appendChild(t),sessionStorage.getItem("pdfjsBreakPoints")&&(r=JSON.parse(sessionStorage.getItem("pdfjsBreakPoints"))),opMap=Object.create(null)
for(var o in e.OPS)opMap[e.OPS[o]]=o},cleanup:function(){a.textContent="",t.textContent="",e=[]},enabled:!1,active:!1,create:function(n){var i=document.createElement("div")
i.id="stepper"+n,i.setAttribute("hidden",!0),i.className="stepper",t.appendChild(i)
var o=document.createElement("option")
o.textContent="Page "+(n+1),o.value=n,a.appendChild(o)
var d=r[n]||[],l=new Stepper(i,n,d)
return e.push(l),1===e.length&&this.selectStepper(n,!1),l},selectStepper:function(t,n){var r
for(t|=0,n&&this.manager.selectPanel(this),r=0;r<e.length;++r){var i=e[r]
i.pageIndex===t?i.panel.removeAttribute("hidden"):i.panel.setAttribute("hidden",!0)}var o=a.options
for(r=0;r<o.length;++r){var d=o[r]
d.selected=(0|d.value)===t}},saveBreakPoints:function(e,t){r[e]=t,sessionStorage.setItem("pdfjsBreakPoints",JSON.stringify(r))}}}(),Stepper=function(){function e(e,t){var n=document.createElement(e)
return t&&(n.textContent=t),n}function t(e){if("string"==typeof e){return e.length<=75?e:e.substr(0,75)+"..."}if("object"!=typeof e||null===e)return e
if("length"in e){var n,a,r=[]
for(n=0,a=Math.min(10,e.length);n<a;n++)r.push(t(e[n]))
return n<e.length&&r.push("..."),r}var i={}
for(var o in e)i[o]=t(e[o])
return i}function n(e,t,n){this.panel=e,this.breakPoint=0,this.nextBreakPoint=null,this.pageIndex=t,this.breakPoints=n,this.currentIdx=-1,this.operatorListIdx=0}return n.prototype={init:function(t){var n=this.panel,a=e("div","c=continue, s=step"),r=e("table")
a.appendChild(r),r.cellSpacing=0
var i=e("tr")
r.appendChild(i),i.appendChild(e("th","Break")),i.appendChild(e("th","Idx")),i.appendChild(e("th","fn")),i.appendChild(e("th","args")),n.appendChild(a),this.table=r,this.updateOperatorList(t)},updateOperatorList:function(n){function a(){var e=+this.dataset.idx
this.checked?r.breakPoints.push(e):r.breakPoints.splice(r.breakPoints.indexOf(e),1),StepperManager.saveBreakPoints(r.pageIndex,r.breakPoints)}var r=this
if(!(this.operatorListIdx>15e3)){for(var i=document.createDocumentFragment(),o=Math.min(15e3,n.fnArray.length),d=this.operatorListIdx;d<o;d++){var l=e("tr")
l.className="line",l.dataset.idx=d,i.appendChild(l)
var s=-1!==this.breakPoints.indexOf(d),c=n.argsArray[d]||[],p=e("td"),u=e("input")
u.type="checkbox",u.className="points",u.checked=s,u.dataset.idx=d,u.onclick=a,p.appendChild(u),l.appendChild(p),l.appendChild(e("td",d.toString()))
var h=opMap[n.fnArray[d]],f=c
if("showText"===h){for(var v=c[0],m=[],g=[],b=0;b<v.length;b++){var C=v[b]
"object"==typeof C&&null!==C?g.push(C.fontChar):(g.length>0&&(m.push(g.join("")),g=[]),m.push(C))}g.length>0&&m.push(g.join("")),f=[m]}l.appendChild(e("td",h)),l.appendChild(e("td",JSON.stringify(t(f))))}if(o<n.fnArray.length){l=e("tr")
var x=e("td","...")
x.colspan=4,i.appendChild(x)}this.operatorListIdx=n.fnArray.length,this.table.appendChild(i)}},getNextBreakPoint:function(){this.breakPoints.sort(function(e,t){return e-t})
for(var e=0;e<this.breakPoints.length;e++)if(this.breakPoints[e]>this.currentIdx)return this.breakPoints[e]
return null},breakIt:function(e,t){StepperManager.selectStepper(this.pageIndex,!0)
var n=this,a=document
n.currentIdx=e
var r=function(e){switch(e.keyCode){case 83:a.removeEventListener("keydown",r),n.nextBreakPoint=n.currentIdx+1,n.goTo(-1),t()
break
case 67:a.removeEventListener("keydown",r)
var i=n.getNextBreakPoint()
n.nextBreakPoint=i,n.goTo(-1),t()}}
a.addEventListener("keydown",r),n.goTo(e)},goTo:function(e){for(var t=this.panel.getElementsByClassName("line"),n=0,a=t.length;n<a;++n){var r=t[n];(0|r.dataset.idx)===e?(r.style.backgroundColor="rgb(251,250,207)",r.scrollIntoView()):r.style.backgroundColor=null}}},n}(),Stats=function(){function e(e){for(;e.hasChildNodes();)e.removeChild(e.lastChild)}function t(e){for(var t=0,a=n.length;t<a;++t)if(n[t].pageNumber===e)return t
return!1}var n=[]
return{id:"Stats",name:"Stats",panel:null,manager:null,init:function(e){this.panel.setAttribute("style","padding: 5px;"),e.PDFJS.enableStats=!0},enabled:!1,active:!1,add:function(a,r){if(r){var i=t(a)
if(!1!==i){var o=n[i]
this.panel.removeChild(o.div),n.splice(i,1)}var d=document.createElement("div")
d.className="stats"
var l=document.createElement("div")
l.className="title",l.textContent="Page: "+a
var s=document.createElement("div")
s.textContent=r.toString(),d.appendChild(l),d.appendChild(s),n.push({pageNumber:a,div:d}),n.sort(function(e,t){return e.pageNumber-t.pageNumber}),e(this.panel)
for(var c=0,p=n.length;c<p;++c)this.panel.appendChild(n[c].div)}},cleanup:function(){n=[],e(this.panel)}}}(),PDFBug=function(){var e=[],t=null
return{tools:[FontInspector,StepperManager,Stats],enable:function(e){var t=!1,n=this.tools
1===e.length&&"all"===e[0]&&(t=!0)
for(var a=0;a<n.length;++a){var r=n[a];(t||-1!==e.indexOf(r.id))&&(r.enabled=!0)}t||n.sort(function(t,a){var r=e.indexOf(t.id)
r=r<0?n.length:r
var i=e.indexOf(a.id)
return i=i<0?n.length:i,r-i})},init:function(t,n){var a=document.createElement("div")
a.id="PDFBug"
var r=document.createElement("div")
r.setAttribute("class","controls"),a.appendChild(r)
var i=document.createElement("div")
i.setAttribute("class","panels"),a.appendChild(i),n.appendChild(a),n.style.right="300px"
for(var o=this.tools,d=this,l=0;l<o.length;++l){var s=o[l],c=document.createElement("div"),p=document.createElement("button")
p.textContent=s.name,p.addEventListener("click",function(e){return function(t){t.preventDefault(),d.selectPanel(e)}}(l)),r.appendChild(p),i.appendChild(c),s.panel=c,s.manager=this,s.enabled?s.init(t):c.textContent=s.name+' is disabled. To enable add  "'+s.id+'" to the pdfBug parameter and refresh (separate multiple by commas).',e.push(p)}this.selectPanel(0)},cleanup:function(){for(var e=0,t=this.tools.length;e<t;e++)this.tools[e].enabled&&this.tools[e].cleanup()},selectPanel:function(n){if("number"!=typeof n&&(n=this.tools.indexOf(n)),n!==t){t=n
for(var a=this.tools,r=0;r<a.length;++r)r===n?(e[r].setAttribute("class","active"),a[r].active=!0,a[r].panel.removeAttribute("hidden")):(e[r].setAttribute("class",""),a[r].active=!1,a[r].panel.setAttribute("hidden","true"))}}}}()
