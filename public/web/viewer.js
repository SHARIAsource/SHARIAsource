/* Copyright 2016 Mozilla Foundation
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
function getViewerConfiguration(){return{appContainer:document.body,mainContainer:document.getElementById("viewerContainer"),viewerContainer:document.getElementById("viewer"),eventBus:null,toolbar:{container:document.getElementById("toolbarViewer"),numPages:document.getElementById("numPages"),pageNumber:document.getElementById("pageNumber"),scaleSelectContainer:document.getElementById("scaleSelectContainer"),scaleSelect:document.getElementById("scaleSelect"),customScaleOption:document.getElementById("customScaleOption"),previous:document.getElementById("previous"),next:document.getElementById("next"),zoomIn:document.getElementById("zoomIn"),zoomOut:document.getElementById("zoomOut"),viewFind:document.getElementById("viewFind"),openFile:document.getElementById("openFile"),print:document.getElementById("print"),presentationModeButton:document.getElementById("presentationMode"),download:document.getElementById("download"),viewBookmark:document.getElementById("viewBookmark")},secondaryToolbar:{toolbar:document.getElementById("secondaryToolbar"),toggleButton:document.getElementById("secondaryToolbarToggle"),toolbarButtonContainer:document.getElementById("secondaryToolbarButtonContainer"),presentationModeButton:document.getElementById("secondaryPresentationMode"),openFileButton:document.getElementById("secondaryOpenFile"),printButton:document.getElementById("secondaryPrint"),downloadButton:document.getElementById("secondaryDownload"),viewBookmarkButton:document.getElementById("secondaryViewBookmark"),firstPageButton:document.getElementById("firstPage"),lastPageButton:document.getElementById("lastPage"),pageRotateCwButton:document.getElementById("pageRotateCw"),pageRotateCcwButton:document.getElementById("pageRotateCcw"),toggleHandToolButton:document.getElementById("toggleHandTool"),documentPropertiesButton:document.getElementById("documentProperties")},fullscreen:{contextFirstPage:document.getElementById("contextFirstPage"),contextLastPage:document.getElementById("contextLastPage"),contextPageRotateCw:document.getElementById("contextPageRotateCw"),contextPageRotateCcw:document.getElementById("contextPageRotateCcw")},sidebar:{mainContainer:document.getElementById("mainContainer"),outerContainer:document.getElementById("outerContainer"),toggleButton:document.getElementById("sidebarToggle"),thumbnailButton:document.getElementById("viewThumbnail"),outlineButton:document.getElementById("viewOutline"),attachmentsButton:document.getElementById("viewAttachments"),thumbnailView:document.getElementById("thumbnailView"),outlineView:document.getElementById("outlineView"),attachmentsView:document.getElementById("attachmentsView")},findBar:{bar:document.getElementById("findbar"),toggleButton:document.getElementById("viewFind"),findField:document.getElementById("findInput"),highlightAllCheckbox:document.getElementById("findHighlightAll"),caseSensitiveCheckbox:document.getElementById("findMatchCase"),findMsg:document.getElementById("findMsg"),findResultsCount:document.getElementById("findResultsCount"),findStatusIcon:document.getElementById("findStatusIcon"),findPreviousButton:document.getElementById("findPrevious"),findNextButton:document.getElementById("findNext")},passwordOverlay:{overlayName:"passwordOverlay",container:document.getElementById("passwordOverlay"),label:document.getElementById("passwordText"),input:document.getElementById("password"),submitButton:document.getElementById("passwordSubmit"),cancelButton:document.getElementById("passwordCancel")},documentProperties:{overlayName:"documentPropertiesOverlay",container:document.getElementById("documentPropertiesOverlay"),closeButton:document.getElementById("documentPropertiesClose"),fields:{fileName:document.getElementById("fileNameField"),fileSize:document.getElementById("fileSizeField"),title:document.getElementById("titleField"),author:document.getElementById("authorField"),subject:document.getElementById("subjectField"),keywords:document.getElementById("keywordsField"),creationDate:document.getElementById("creationDateField"),modificationDate:document.getElementById("modificationDateField"),creator:document.getElementById("creatorField"),producer:document.getElementById("producerField"),version:document.getElementById("versionField"),pageCount:document.getElementById("pageCountField")}},errorWrapper:{container:document.getElementById("errorWrapper"),errorMessage:document.getElementById("errorMessage"),closeButton:document.getElementById("errorClose"),errorMoreInfo:document.getElementById("errorMoreInfo"),moreInfoButton:document.getElementById("errorShowMore"),lessInfoButton:document.getElementById("errorShowLess")},printContainer:document.getElementById("printContainer"),openFileInputName:"fileInput",debuggerScriptPath:"./debugger.js"}}function webViewerLoad(){var e=getViewerConfiguration()
window.PDFViewerApplication=pdfjsWebLibs.pdfjsWebApp.PDFViewerApplication,pdfjsWebLibs.pdfjsWebApp.PDFViewerApplication.run(e)}var DEFAULT_URL="compressed.tracemonkey-pldi-09.pdf",pdfjsWebLibs
pdfjsWebLibs={pdfjsWebPDFJS:window.pdfjsDistBuildPdf},function(){!function(e,t){!function(e){function t(e){this.element=e.element,this.document=e.element.ownerDocument,"function"==typeof e.ignoreTarget&&(this.ignoreTarget=e.ignoreTarget),this.onActiveChanged=e.onActiveChanged,this.activate=this.activate.bind(this),this.deactivate=this.deactivate.bind(this),this.toggle=this.toggle.bind(this),this._onmousedown=this._onmousedown.bind(this),this._onmousemove=this._onmousemove.bind(this),this._endPan=this._endPan.bind(this),(this.overlay=document.createElement("div")).className="grab-to-pan-grabbing"}function i(e){return"buttons"in e&&s?!(1&e.buttons):a||o?0===e.which:void 0}t.prototype={CSS_CLASS_GRAB:"grab-to-pan-grab",activate:function(){this.active||(this.active=!0,this.element.addEventListener("mousedown",this._onmousedown,!0),this.element.classList.add(this.CSS_CLASS_GRAB),this.onActiveChanged&&this.onActiveChanged(!0))},deactivate:function(){this.active&&(this.active=!1,this.element.removeEventListener("mousedown",this._onmousedown,!0),this._endPan(),this.element.classList.remove(this.CSS_CLASS_GRAB),this.onActiveChanged&&this.onActiveChanged(!1))},toggle:function(){this.active?this.deactivate():this.activate()},ignoreTarget:function(e){return e[n]("a[href], a[href] *, input, textarea, button, button *, select, option")},_onmousedown:function(e){if(0===e.button&&!this.ignoreTarget(e.target)){if(e.originalTarget)try{e.originalTarget.tagName}catch(e){return}this.scrollLeftStart=this.element.scrollLeft,this.scrollTopStart=this.element.scrollTop,this.clientXStart=e.clientX,this.clientYStart=e.clientY,this.document.addEventListener("mousemove",this._onmousemove,!0),this.document.addEventListener("mouseup",this._endPan,!0),this.element.addEventListener("scroll",this._endPan,!0),e.preventDefault(),e.stopPropagation()
var t=document.activeElement
t&&!t.contains(e.target)&&t.blur()}},_onmousemove:function(e){if(this.element.removeEventListener("scroll",this._endPan,!0),i(e))return void this._endPan()
var t=e.clientX-this.clientXStart,n=e.clientY-this.clientYStart,s=this.scrollTopStart-n,r=this.scrollLeftStart-t
this.element.scrollTo?this.element.scrollTo({top:s,left:r,behavior:"instant"}):(this.element.scrollTop=s,this.element.scrollLeft=r),this.overlay.parentNode||document.body.appendChild(this.overlay)},_endPan:function(){this.element.removeEventListener("scroll",this._endPan,!0),this.document.removeEventListener("mousemove",this._onmousemove,!0),this.document.removeEventListener("mouseup",this._endPan,!0),this.overlay.parentNode&&this.overlay.parentNode.removeChild(this.overlay)}}
var n;["webkitM","mozM","msM","oM","m"].some(function(e){var t=e+"atches"
return t in document.documentElement&&(n=t),t+="Selector",t in document.documentElement&&(n=t),n})
var s=!document.documentMode||document.documentMode>9,r=window.chrome,a=r&&(r.webstore||r.app),o=/Apple/.test(navigator.vendor)&&/Version\/([6-9]\d*|[1-5]\d+)/.test(navigator.userAgent)
e.GrabToPan=t}(e.pdfjsWebGrabToPan={})}(this),function(e,t){!function(e){var t={overlays:{},active:null,register:function(e,t,i,n){return new Promise(function(s){var r
if(!(e&&t&&(r=t.parentNode)))throw new Error("Not enough parameters.")
if(this.overlays[e])throw new Error("The overlay is already registered.")
this.overlays[e]={element:t,container:r,callerCloseMethod:i||null,canForceClose:n||!1},s()}.bind(this))},unregister:function(e){return new Promise(function(t){if(!this.overlays[e])throw new Error("The overlay does not exist.")
if(this.active===e)throw new Error("The overlay cannot be removed while it is active.")
delete this.overlays[e],t()}.bind(this))},open:function(e){return new Promise(function(t){if(!this.overlays[e])throw new Error("The overlay does not exist.")
if(this.active){if(!this.overlays[e].canForceClose)throw this.active===e?new Error("The overlay is already active."):new Error("Another overlay is currently active.")
this._closeThroughCaller()}this.active=e,this.overlays[this.active].element.classList.remove("hidden"),this.overlays[this.active].container.classList.remove("hidden"),window.addEventListener("keydown",this._keyDown),t()}.bind(this))},close:function(e){return new Promise(function(t){if(!this.overlays[e])throw new Error("The overlay does not exist.")
if(!this.active)throw new Error("The overlay is currently not active.")
if(this.active!==e)throw new Error("Another overlay is currently active.")
this.overlays[this.active].container.classList.add("hidden"),this.overlays[this.active].element.classList.add("hidden"),this.active=null,window.removeEventListener("keydown",this._keyDown),t()}.bind(this))},_keyDown:function(e){var i=t
i.active&&27===e.keyCode&&(i._closeThroughCaller(),e.preventDefault())},_closeThroughCaller:function(){this.overlays[this.active].callerCloseMethod&&this.overlays[this.active].callerCloseMethod(),this.active&&this.close(this.active)}}
e.OverlayManager=t}(e.pdfjsWebOverlayManager={})}(this),function(e,t){!function(e){var t={INITIAL:0,RUNNING:1,PAUSED:2,FINISHED:3},i=function(){function e(){this.pdfViewer=null,this.pdfThumbnailViewer=null,this.onIdle=null,this.highestPriorityPage=null,this.idleTimeout=null,this.printing=!1,this.isThumbnailViewEnabled=!1}return e.prototype={setViewer:function(e){this.pdfViewer=e},setThumbnailViewer:function(e){this.pdfThumbnailViewer=e},isHighestPriority:function(e){return this.highestPriorityPage===e.renderingId},renderHighestPriority:function(e){this.idleTimeout&&(clearTimeout(this.idleTimeout),this.idleTimeout=null),this.pdfViewer.forceRendering(e)||this.pdfThumbnailViewer&&this.isThumbnailViewEnabled&&this.pdfThumbnailViewer.forceRendering()||this.printing||this.onIdle&&(this.idleTimeout=setTimeout(this.onIdle.bind(this),3e4))},getHighestPriority:function(e,t,i){var n=e.views,s=n.length
if(0===s)return!1
for(var r=0;r<s;++r){var a=n[r].view
if(!this.isViewFinished(a))return a}if(i){var o=e.last.id
if(t[o]&&!this.isViewFinished(t[o]))return t[o]}else{var h=e.first.id-2
if(t[h]&&!this.isViewFinished(t[h]))return t[h]}return null},isViewFinished:function(e){return e.renderingState===t.FINISHED},renderView:function(e){switch(e.renderingState){case t.FINISHED:return!1
case t.PAUSED:this.highestPriorityPage=e.renderingId,e.resume()
break
case t.RUNNING:this.highestPriorityPage=e.renderingId
break
case t.INITIAL:this.highestPriorityPage=e.renderingId
var i=function(){this.renderHighestPriority()}.bind(this)
e.draw().then(i,i)}return!0}},e}()
e.RenderingStates=t,e.PDFRenderingQueue=i}(e.pdfjsWebPDFRenderingQueue={})}(this),function(e,t){!function(e){function t(){return n||(n=Promise.resolve({showPreviousViewOnLoad:!0,defaultZoomValue:"",sidebarViewOnLoad:0,enableHandToolOnLoad:!1,enableWebGL:!1,pdfBugEnabled:!1,disableRange:!1,disableStream:!1,disableAutoFetch:!1,disableFontFace:!1,disableTextLayer:!1,useOnlyCssZoom:!1,externalLinkTarget:0,enhanceTextSelection:!1,renderer:"canvas",renderInteractiveForms:!1,disablePageLabels:!1})),n}function i(e){var t={}
for(var i in e)Object.prototype.hasOwnProperty.call(e,i)&&(t[i]=e[i])
return t}var n=null,s={prefs:null,isInitializedPromiseResolved:!1,initializedPromise:null,initialize:function(){return this.initializedPromise=t().then(function(e){return Object.defineProperty(this,"defaults",{value:Object.freeze(e),writable:!1,enumerable:!0,configurable:!1}),this.prefs=i(e),this._readFromStorage(e)}.bind(this)).then(function(e){this.isInitializedPromiseResolved=!0,e&&(this.prefs=e)}.bind(this))},_writeToStorage:function(e){return Promise.resolve()},_readFromStorage:function(e){return Promise.resolve()},reset:function(){return this.initializedPromise.then(function(){return this.prefs=i(this.defaults),this._writeToStorage(this.defaults)}.bind(this))},reload:function(){return this.initializedPromise.then(function(){this._readFromStorage(this.defaults).then(function(e){e&&(this.prefs=e)}.bind(this))}.bind(this))},set:function(e,t){return this.initializedPromise.then(function(){if(void 0===this.defaults[e])throw new Error("preferencesSet: '"+e+"' is undefined.")
if(void 0===t)throw new Error("preferencesSet: no value is specified.")
var i=typeof t,n=typeof this.defaults[e]
if(i!==n){if("number"!==i||"string"!==n)throw new Error("Preferences_set: '"+t+"' is a \""+i+'", expected "'+n+'".')
t=t.toString()}else if("number"===i&&(0|t)!==t)throw new Error("Preferences_set: '"+t+'\' must be an "integer".')
return this.prefs[e]=t,this._writeToStorage(this.prefs)}.bind(this))},get:function(e){return this.initializedPromise.then(function(){var t=this.defaults[e]
if(void 0===t)throw new Error("preferencesGet: '"+e+"' is undefined.")
var i=this.prefs[e]
return void 0!==i?i:t}.bind(this))}}
s._writeToStorage=function(e){return new Promise(function(t){localStorage.setItem("pdfjs.preferences",JSON.stringify(e)),t()})},s._readFromStorage=function(e){return new Promise(function(e){e(JSON.parse(localStorage.getItem("pdfjs.preferences")))})},e.Preferences=s}(e.pdfjsWebPreferences={})}(this),function(e,t){!function(e){var t=20,i=function(){function e(e,i){this.fingerprint=e,this.cacheSize=i||t,this.isInitializedPromiseResolved=!1,this.initializedPromise=this._readFromStorage().then(function(e){this.isInitializedPromiseResolved=!0
var t=JSON.parse(e||"{}")
"files"in t||(t.files=[]),t.files.length>=this.cacheSize&&t.files.shift()
for(var i,n=0,s=t.files.length;n<s;n++){if(t.files[n].fingerprint===this.fingerprint){i=n
break}}"number"!=typeof i&&(i=t.files.push({fingerprint:this.fingerprint})-1),this.file=t.files[i],this.database=t}.bind(this))}return e.prototype={_writeToStorage:function(){return new Promise(function(e){var t=JSON.stringify(this.database)
localStorage.setItem("pdfjs.history",t),e()}.bind(this))},_readFromStorage:function(){return new Promise(function(e){var t=localStorage.getItem("pdfjs.history")
if(!t){var i=localStorage.getItem("database")
if(i)try{"string"==typeof JSON.parse(i).files[0].fingerprint&&(localStorage.setItem("pdfjs.history",i),localStorage.removeItem("database"),t=i)}catch(e){}}e(t)})},set:function(e,t){if(this.isInitializedPromiseResolved)return this.file[e]=t,this._writeToStorage()},setMultiple:function(e){if(this.isInitializedPromiseResolved){for(var t in e)this.file[t]=e[t]
return this._writeToStorage()}},get:function(e,t){return this.isInitializedPromiseResolved?this.file[e]||t:t}},e}()
e.ViewHistory=i}(e.pdfjsWebViewHistory={})}(this),function(e,t){!function(e,t){function i(e,t){var i=document.createElement("a")
if(i.click)i.href=e,i.target="_parent","download"in i&&(i.download=t),(document.body||document.documentElement).appendChild(i),i.click(),i.parentNode.removeChild(i)
else{if(window.top===window&&e.split("#")[0]===window.location.href.split("#")[0]){var n=-1===e.indexOf("?")?"?":"&"
e=e.replace(/#|$/,n+"$&")}window.open(e,"_parent")}}function n(){}n.prototype={downloadUrl:function(e,n){t.createValidAbsoluteUrl(e,"http://example.com")&&i(e+"#pdfjs.action=download",n)},downloadData:function(e,n,s){if(navigator.msSaveBlob)return navigator.msSaveBlob(new Blob([e],{type:s}),n)
i(t.createObjectURL(e,s,t.PDFJS.disableCreateObjectURL),n)},download:function(e,t,n){return URL?navigator.msSaveBlob?void(navigator.msSaveBlob(e,n)||this.downloadUrl(t,n)):void i(URL.createObjectURL(e),n):void this.downloadUrl(t,n)}},e.DownloadManager=n}(e.pdfjsWebDownloadManager={},e.pdfjsWebPDFJS)}(this),function(e,t){!function(e,t){var i=function(){function e(e){this.attachments=null,this.container=e.container,this.eventBus=e.eventBus,this.downloadManager=e.downloadManager}return e.prototype={reset:function(){this.attachments=null
for(var e=this.container;e.firstChild;)e.removeChild(e.firstChild)},_dispatchEvent:function(e){this.eventBus.dispatch("attachmentsloaded",{source:this,attachmentsCount:e})},_bindLink:function(e,t,i){e.onclick=function(e){return this.downloadManager.downloadData(t,i,""),!1}.bind(this)},render:function(e){var i=e&&e.attachments||null,n=0
if(this.attachments&&this.reset(),this.attachments=i,!i)return void this._dispatchEvent(n)
var s=Object.keys(i).sort(function(e,t){return e.toLowerCase().localeCompare(t.toLowerCase())})
n=s.length
for(var r=0;r<n;r++){var a=i[s[r]],o=t.getFilenameFromUrl(a.filename),h=document.createElement("div")
h.className="attachmentsItem"
var d=document.createElement("button")
this._bindLink(d,a.content,o),d.textContent=t.removeNullCharacters(o),h.appendChild(d),this.container.appendChild(h)}this._dispatchEvent(n)}},e}()
e.PDFAttachmentViewer=i}(e.pdfjsWebPDFAttachmentViewer={},e.pdfjsWebPDFJS)}(this),function(e,t){!function(e,t){var i=t.PDFJS,n=function(){function e(e){this.outline=null,this.lastToggleIsShow=!0,this.container=e.container,this.linkService=e.linkService,this.eventBus=e.eventBus}return e.prototype={reset:function(){this.outline=null,this.lastToggleIsShow=!0
for(var e=this.container;e.firstChild;)e.removeChild(e.firstChild)},_dispatchEvent:function(e){this.eventBus.dispatch("outlineloaded",{source:this,outlineCount:e})},_bindLink:function(e,n){if(n.url)return void t.addLinkAttributes(e,{url:n.url,target:n.newWindow?i.LinkTarget.BLANK:void 0})
var s=this,r=n.dest
e.href=s.linkService.getDestinationHash(r),e.onclick=function(){return r&&s.linkService.navigateTo(r),!1}},_setStyles:function(e,t){var i=""
t.bold&&(i+="font-weight: bold;"),t.italic&&(i+="font-style: italic;"),i&&e.setAttribute("style",i)},_addToggleButton:function(e){var t=document.createElement("div")
t.className="outlineItemToggler",t.onclick=function(i){if(i.stopPropagation(),t.classList.toggle("outlineItemsHidden"),i.shiftKey){var n=!t.classList.contains("outlineItemsHidden")
this._toggleOutlineItem(e,n)}}.bind(this),e.insertBefore(t,e.firstChild)},_toggleOutlineItem:function(e,t){this.lastToggleIsShow=t
for(var i=e.querySelectorAll(".outlineItemToggler"),n=0,s=i.length;n<s;++n)i[n].classList[t?"remove":"add"]("outlineItemsHidden")},toggleOutlineTree:function(){this.outline&&this._toggleOutlineItem(this.container,!this.lastToggleIsShow)},render:function(e){var i=e&&e.outline||null,n=0
if(this.outline&&this.reset(),this.outline=i,!i)return void this._dispatchEvent(n)
for(var s=document.createDocumentFragment(),r=[{parent:s,items:this.outline}],a=!1;r.length>0;)for(var o=r.shift(),h=0,d=o.items.length;h<d;h++){var c=o.items[h],l=document.createElement("div")
l.className="outlineItem"
var u=document.createElement("a")
if(this._bindLink(u,c),this._setStyles(u,c),u.textContent=t.removeNullCharacters(c.title)||"–",l.appendChild(u),c.items.length>0){a=!0,this._addToggleButton(l)
var f=document.createElement("div")
f.className="outlineItems",l.appendChild(f),r.push({parent:f,items:c.items})}o.parent.appendChild(l),n++}a&&this.container.classList.add("outlineWithDeepNesting"),this.container.appendChild(s),this._dispatchEvent(n)}},e}()
e.PDFOutlineViewer=n}(e.pdfjsWebPDFOutlineViewer={},e.pdfjsWebPDFJS)}(this),function(e,t){!function(e,t){var i=t.RenderingStates,n={NONE:0,THUMBS:1,OUTLINE:2,ATTACHMENTS:3},s=function(){function e(e){this.isOpen=!1,this.active=n.THUMBS,this.isInitialViewSet=!1,this.onToggled=null,this.pdfViewer=e.pdfViewer,this.pdfThumbnailViewer=e.pdfThumbnailViewer,this.pdfOutlineViewer=e.pdfOutlineViewer,this.mainContainer=e.mainContainer,this.outerContainer=e.outerContainer,this.eventBus=e.eventBus,this.toggleButton=e.toggleButton,this.thumbnailButton=e.thumbnailButton,this.outlineButton=e.outlineButton,this.attachmentsButton=e.attachmentsButton,this.thumbnailView=e.thumbnailView,this.outlineView=e.outlineView,this.attachmentsView=e.attachmentsView,this._addEventListeners()}return e.prototype={reset:function(){this.isInitialViewSet=!1,this.close(),this.switchView(n.THUMBS),this.outlineButton.disabled=!1,this.attachmentsButton.disabled=!1},get visibleView(){return this.isOpen?this.active:n.NONE},get isThumbnailViewVisible(){return this.isOpen&&this.active===n.THUMBS},get isOutlineViewVisible(){return this.isOpen&&this.active===n.OUTLINE},get isAttachmentsViewVisible(){return this.isOpen&&this.active===n.ATTACHMENTS},setInitialView:function(e){if(!this.isInitialViewSet){if(this.isInitialViewSet=!0,this.isOpen&&e===n.NONE)return void this._dispatchEvent()
var t=e===this.visibleView
this.switchView(e,!0),t&&this._dispatchEvent()}},switchView:function(e,t){if(e===n.NONE)return void this.close()
var i=e!==this.active,s=!1
switch(e){case n.THUMBS:this.thumbnailButton.classList.add("toggled"),this.outlineButton.classList.remove("toggled"),this.attachmentsButton.classList.remove("toggled"),this.thumbnailView.classList.remove("hidden"),this.outlineView.classList.add("hidden"),this.attachmentsView.classList.add("hidden"),this.isOpen&&i&&(this._updateThumbnailViewer(),s=!0)
break
case n.OUTLINE:if(this.outlineButton.disabled)return
this.thumbnailButton.classList.remove("toggled"),this.outlineButton.classList.add("toggled"),this.attachmentsButton.classList.remove("toggled"),this.thumbnailView.classList.add("hidden"),this.outlineView.classList.remove("hidden"),this.attachmentsView.classList.add("hidden")
break
case n.ATTACHMENTS:if(this.attachmentsButton.disabled)return
this.thumbnailButton.classList.remove("toggled"),this.outlineButton.classList.remove("toggled"),this.attachmentsButton.classList.add("toggled"),this.thumbnailView.classList.add("hidden"),this.outlineView.classList.add("hidden"),this.attachmentsView.classList.remove("hidden")
break
default:return void console.error('PDFSidebar_switchView: "'+e+'" is an unsupported value.')}if(this.active=0|e,t&&!this.isOpen)return void this.open()
s&&this._forceRendering(),i&&this._dispatchEvent()},open:function(){this.isOpen||(this.isOpen=!0,this.toggleButton.classList.add("toggled"),this.outerContainer.classList.add("sidebarMoving"),this.outerContainer.classList.add("sidebarOpen"),this.active===n.THUMBS&&this._updateThumbnailViewer(),this._forceRendering(),this._dispatchEvent())},close:function(){this.isOpen&&(this.isOpen=!1,this.toggleButton.classList.remove("toggled"),this.outerContainer.classList.add("sidebarMoving"),this.outerContainer.classList.remove("sidebarOpen"),this._forceRendering(),this._dispatchEvent())},toggle:function(){this.isOpen?this.close():this.open()},_dispatchEvent:function(){this.eventBus.dispatch("sidebarviewchanged",{source:this,view:this.visibleView})},_forceRendering:function(){this.onToggled?this.onToggled():(this.pdfViewer.forceRendering(),this.pdfThumbnailViewer.forceRendering())},_updateThumbnailViewer:function(){for(var e=this.pdfViewer,t=this.pdfThumbnailViewer,n=e.pagesCount,s=0;s<n;s++){var r=e.getPageView(s)
if(r&&r.renderingState===i.FINISHED){t.getThumbnail(s).setImage(r)}}t.scrollThumbnailIntoView(e.currentPageNumber)},_addEventListeners:function(){var e=this
e.mainContainer.addEventListener("transitionend",function(t){t.target===this&&e.outerContainer.classList.remove("sidebarMoving")}),e.thumbnailButton.addEventListener("click",function(){e.switchView(n.THUMBS)}),e.outlineButton.addEventListener("click",function(){e.switchView(n.OUTLINE)}),e.outlineButton.addEventListener("dblclick",function(){e.pdfOutlineViewer.toggleOutlineTree()}),e.attachmentsButton.addEventListener("click",function(){e.switchView(n.ATTACHMENTS)}),e.eventBus.on("outlineloaded",function(t){var i=t.outlineCount
e.outlineButton.disabled=!i,i||e.active!==n.OUTLINE||e.switchView(n.THUMBS)}),e.eventBus.on("attachmentsloaded",function(t){var i=t.attachmentsCount
e.attachmentsButton.disabled=!i,i||e.active!==n.ATTACHMENTS||e.switchView(n.THUMBS)}),e.eventBus.on("presentationmodechanged",function(t){t.active||t.switchInProgress||!e.isThumbnailViewVisible||e._updateThumbnailViewer()})}},e}()
e.SidebarView=n,e.PDFSidebar=s}(e.pdfjsWebPDFSidebar={},e.pdfjsWebPDFRenderingQueue)}(this),function(e,t){!function(e,t){function i(e){var t=window.devicePixelRatio||1,i=e.webkitBackingStorePixelRatio||e.mozBackingStorePixelRatio||e.msBackingStorePixelRatio||e.oBackingStorePixelRatio||e.backingStorePixelRatio||1,n=t/i
return{sx:n,sy:n,scaled:1!==n}}function n(e,t,i){var n=e.offsetParent
if(!n)return void console.error("offsetParent is not set -- cannot scroll")
for(var s=i||!1,r=e.offsetTop+e.clientTop,a=e.offsetLeft+e.clientLeft;n.clientHeight===n.scrollHeight||s&&"hidden"===getComputedStyle(n).overflow;)if(n.dataset._scaleY&&(r/=n.dataset._scaleY,a/=n.dataset._scaleX),r+=n.offsetTop,a+=n.offsetLeft,!(n=n.offsetParent))return
t&&(void 0!==t.top&&(r+=t.top),void 0!==t.left&&(a+=t.left,n.scrollLeft=a)),n.scrollTop=r}function s(e,t){var i=function(i){s||(s=window.requestAnimationFrame(function(){s=null
var i=e.scrollTop,r=n.lastY
i!==r&&(n.down=i>r),n.lastY=i,t(n)}))},n={down:!0,lastY:e.scrollTop,_eventHandler:i},s=null
return e.addEventListener("scroll",i,!0),n}function r(e){for(var t=e.split("&"),i={},n=0,s=t.length;n<s;++n){var r=t[n].split("="),a=r[0].toLowerCase(),o=r.length>1?r[1]:null
i[decodeURIComponent(a)]=decodeURIComponent(o)}return i}function a(e,t){var i=0,n=e.length-1
if(0===e.length||!t(e[n]))return e.length
if(t(e[i]))return i
for(;i<n;){var s=i+n>>1
t(e[s])?n=s:i=s+1}return i}function o(e){if(Math.floor(e)===e)return[e,1]
var t=1/e
if(t>8)return[1,8]
if(Math.floor(t)===t)return[1,t]
for(var i=e>1?t:e,n=0,s=1,r=1,a=1;;){var o=n+r,h=s+a
if(h>8)break
i<=o/h?(r=o,a=h):(n=o,s=h)}return i-n/s<r/a-i?i===e?[n,s]:[s,n]:i===e?[r,a]:[a,r]}function h(e,t){var i=e%t
return 0===i?e:Math.round(e-i+t)}function d(e,t,i){function n(e){var t=e.div
return t.offsetTop+t.clientTop+t.clientHeight>f}for(var s,r,o,h,d,c,l,u,f=e.scrollTop,g=f+e.clientHeight,p=e.scrollLeft,v=p+e.clientWidth,m=[],b=0===t.length?0:a(t,n),w=b,P=t.length;w<P&&(s=t[w],r=s.div,o=r.offsetTop+r.clientTop,h=r.clientHeight,!(o>g));w++)l=r.offsetLeft+r.clientLeft,u=r.clientWidth,l+u<p||l>v||(d=Math.max(0,f-o)+Math.max(0,o+h-g),c=100*(h-d)/h|0,m.push({id:s.id,x:l,y:o,view:s,percent:c}))
var y=m[0],S=m[m.length-1]
return i&&m.sort(function(e,t){var i=e.percent-t.percent
return Math.abs(i)>.001?-i:e.id-t.id}),{first:y,last:S,views:m}}function c(e){e.preventDefault()}function l(e){var t=/^(?:([^:]+:)?\/\/[^\/]+)?([^?#]*)(\?[^#]*)?(#.*)?$/,i=/[^\/?#=]+\.pdf\b(?!.*\.pdf\b)/i,n=t.exec(e),s=i.exec(n[1])||i.exec(n[2])||i.exec(n[3])
if(s&&(s=s[0],-1!==s.indexOf("%")))try{s=i.exec(decodeURIComponent(s))[0]}catch(e){}return s||"document.pdf"}function u(e){var t=Math.sqrt(e.deltaX*e.deltaX+e.deltaY*e.deltaY),i=Math.atan2(e.deltaY,e.deltaX);-.25*Math.PI<i&&i<.75*Math.PI&&(t=-t)
return 0===e.deltaMode?t/=900:1===e.deltaMode&&(t/=30),t}var f={CANVAS:"canvas",SVG:"svg"},g=document.mozL10n||document.webL10n,p=t.PDFJS
p.disableFullscreen=void 0!==p.disableFullscreen&&p.disableFullscreen,p.useOnlyCssZoom=void 0!==p.useOnlyCssZoom&&p.useOnlyCssZoom,p.maxCanvasPixels=void 0===p.maxCanvasPixels?16777216:p.maxCanvasPixels,p.disableHistory=void 0!==p.disableHistory&&p.disableHistory,p.disableTextLayer=void 0!==p.disableTextLayer&&p.disableTextLayer,p.ignoreCurrentPositionOnZoom=void 0!==p.ignoreCurrentPositionOnZoom&&p.ignoreCurrentPositionOnZoom,p.locale=void 0===p.locale?navigator.language:p.locale
var v=new Promise(function(e){window.requestAnimationFrame(e)}),m=new Promise(function(e,t){return g?"loading"!==g.getReadyState()?void e():void window.addEventListener("localized",function(t){e()}):void e()}),b=function(){function e(){this._listeners=Object.create(null)}return e.prototype={on:function(e,t){var i=this._listeners[e]
i||(i=[],this._listeners[e]=i),i.push(t)},off:function(e,t){var i,n=this._listeners[e]
!n||(i=n.indexOf(t))<0||n.splice(i,1)},dispatch:function(e){var t=this._listeners[e]
if(t&&0!==t.length){var i=Array.prototype.slice.call(arguments,1)
t.slice(0).forEach(function(e){e.apply(null,i)})}}},e}(),w=function(){function e(e,t,i){return Math.min(Math.max(e,t),i)}function t(e,t){this.visible=!0,this.div=document.querySelector(e+" .progress"),this.bar=this.div.parentNode,this.height=t.height||100,this.width=t.width||100,this.units=t.units||"%",this.div.style.height=this.height+this.units,this.percent=0}return t.prototype={updateBar:function(){if(this._indeterminate)return this.div.classList.add("indeterminate"),void(this.div.style.width=this.width+this.units)
this.div.classList.remove("indeterminate")
var e=this.width*this._percent/100
this.div.style.width=e+this.units},get percent(){return this._percent},set percent(t){this._indeterminate=isNaN(t),this._percent=e(t,0,100),this.updateBar()},setWidth:function(e){if(e){var t=e.parentNode,i=t.offsetWidth-e.offsetWidth
i>0&&this.bar.setAttribute("style","width: calc(100% - "+i+"px);")}},hide:function(){this.visible&&(this.visible=!1,this.bar.classList.add("hidden"),document.body.classList.remove("loadingInProgress"))},show:function(){this.visible||(this.visible=!0,document.body.classList.add("loadingInProgress"),this.bar.classList.remove("hidden"))}},t}()
e.CSS_UNITS=96/72,e.DEFAULT_SCALE_VALUE="auto",e.DEFAULT_SCALE=1,e.MIN_SCALE=.25,e.MAX_SCALE=10,e.UNKNOWN_SCALE=0,e.MAX_AUTO_SCALE=1.25,e.SCROLLBAR_PADDING=40,e.VERTICAL_PADDING=5,e.RendererType=f,e.mozL10n=g,e.EventBus=b,e.ProgressBar=w,e.getPDFFileNameFromURL=l,e.noContextMenuHandler=c,e.parseQueryString=r,e.getVisibleElements=d,e.roundToDivide=h,e.approximateFraction=o,e.getOutputScale=i,e.scrollIntoView=n,e.watchScroll=s,e.binarySearchFirstItem=a,e.normalizeWheelEventDelta=u,e.animationStarted=v,e.localized=m}(e.pdfjsWebUIUtils={},e.pdfjsWebPDFJS)}(this),function(e,t){!function(e,t){function i(e){e.on("documentload",function(){var e=document.createEvent("CustomEvent")
e.initCustomEvent("documentload",!0,!0,{}),window.dispatchEvent(e)}),e.on("pagerendered",function(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent("pagerendered",!0,!0,{pageNumber:e.pageNumber,cssTransform:e.cssTransform}),e.source.div.dispatchEvent(t)}),e.on("textlayerrendered",function(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent("textlayerrendered",!0,!0,{pageNumber:e.pageNumber}),e.source.textLayerDiv.dispatchEvent(t)}),e.on("pagechange",function(e){var t=document.createEvent("UIEvents")
t.initUIEvent("pagechange",!0,!0,window,0),t.pageNumber=e.pageNumber,e.source.container.dispatchEvent(t)}),e.on("pagesinit",function(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent("pagesinit",!0,!0,null),e.source.container.dispatchEvent(t)}),e.on("pagesloaded",function(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent("pagesloaded",!0,!0,{pagesCount:e.pagesCount}),e.source.container.dispatchEvent(t)}),e.on("scalechange",function(e){var t=document.createEvent("UIEvents")
t.initUIEvent("scalechange",!0,!0,window,0),t.scale=e.scale,t.presetValue=e.presetValue,e.source.container.dispatchEvent(t)}),e.on("updateviewarea",function(e){var t=document.createEvent("UIEvents")
t.initUIEvent("updateviewarea",!0,!0,window,0),t.location=e.location,e.source.container.dispatchEvent(t)}),e.on("find",function(e){if(e.source!==window){var t=document.createEvent("CustomEvent")
t.initCustomEvent("find"+e.type,!0,!0,{query:e.query,phraseSearch:e.phraseSearch,caseSensitive:e.caseSensitive,highlightAll:e.highlightAll,findPrevious:e.findPrevious}),window.dispatchEvent(t)}}),e.on("attachmentsloaded",function(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent("attachmentsloaded",!0,!0,{attachmentsCount:e.attachmentsCount}),e.source.container.dispatchEvent(t)}),e.on("sidebarviewchanged",function(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent("sidebarviewchanged",!0,!0,{view:e.view}),e.source.outerContainer.dispatchEvent(t)}),e.on("pagemode",function(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent("pagemode",!0,!0,{mode:e.mode}),e.source.pdfViewer.container.dispatchEvent(t)}),e.on("namedaction",function(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent("namedaction",!0,!0,{action:e.action}),e.source.pdfViewer.container.dispatchEvent(t)}),e.on("presentationmodechanged",function(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent("presentationmodechanged",!0,!0,{active:e.active,switchInProgress:e.switchInProgress}),window.dispatchEvent(t)}),e.on("outlineloaded",function(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent("outlineloaded",!0,!0,{outlineCount:e.outlineCount}),e.source.container.dispatchEvent(t)})}function n(){return r||(r=new s,i(r),r)}var s=t.EventBus,r=null
e.attachDOMEventsToEventBus=i,e.getGlobalEventBus=n}(e.pdfjsWebDOMEvents={},e.pdfjsWebUIUtils)}(this),function(e,t){!function(e,t,i,n){var s=t.GrabToPan,r=i.Preferences,a=n.localized,o=function(){function e(e){this.container=e.container,this.eventBus=e.eventBus,this.wasActive=!1,this.handTool=new s({element:this.container,onActiveChanged:function(e){this.eventBus.dispatch("handtoolchanged",{isActive:e})}.bind(this)}),this.eventBus.on("togglehandtool",this.toggle.bind(this)),Promise.all([a,r.get("enableHandToolOnLoad")]).then(function(e){!0===e[1]&&this.handTool.activate()}.bind(this)).catch(function(e){}),this.eventBus.on("presentationmodechanged",function(e){e.switchInProgress||(e.active?this.enterPresentationMode():this.exitPresentationMode())}.bind(this))}return e.prototype={get isActive(){return!!this.handTool.active},toggle:function(){this.handTool.toggle()},enterPresentationMode:function(){this.isActive&&(this.wasActive=!0,this.handTool.deactivate())},exitPresentationMode:function(){this.wasActive&&(this.wasActive=!1,this.handTool.activate())}},e}()
e.HandTool=o}(e.pdfjsWebHandTool={},e.pdfjsWebGrabToPan,e.pdfjsWebPreferences,e.pdfjsWebUIUtils)}(this),function(e,t){!function(e,t,i,n){var s=t.mozL10n,r=i.OverlayManager,a=function(){function e(e){this.overlayName=e.overlayName,this.container=e.container,this.label=e.label,this.input=e.input,this.submitButton=e.submitButton,this.cancelButton=e.cancelButton,this.updateCallback=null,this.reason=null,this.submitButton.addEventListener("click",this.verify.bind(this)),this.cancelButton.addEventListener("click",this.close.bind(this)),this.input.addEventListener("keydown",function(e){13===e.keyCode&&this.verify()}.bind(this)),r.register(this.overlayName,this.container,this.close.bind(this),!0)}return e.prototype={open:function(){r.open(this.overlayName).then(function(){this.input.type="password",this.input.focus()
var e=s.get("password_label",null,"Enter the password to open this PDF file.")
this.reason===n.PasswordResponses.INCORRECT_PASSWORD&&(e=s.get("password_invalid",null,"Invalid password. Please try again.")),this.label.textContent=e}.bind(this))},close:function(){r.close(this.overlayName).then(function(){this.input.value="",this.input.type=""}.bind(this))},verify:function(){var e=this.input.value
if(e&&e.length>0)return this.close(),this.updateCallback(e)},setUpdateCallback:function(e,t){this.updateCallback=e,this.reason=t}},e}()
e.PasswordPrompt=a}(e.pdfjsWebPasswordPrompt={},e.pdfjsWebUIUtils,e.pdfjsWebOverlayManager,e.pdfjsWebPDFJS)}(this),function(e,t){!function(e,t,i){var n=t.getPDFFileNameFromURL,s=t.mozL10n,r=i.OverlayManager,a=function(){function e(e){this.fields=e.fields,this.overlayName=e.overlayName,this.container=e.container,this.rawFileSize=0,this.url=null,this.pdfDocument=null,e.closeButton&&e.closeButton.addEventListener("click",this.close.bind(this)),this.dataAvailablePromise=new Promise(function(e){this.resolveDataAvailable=e}.bind(this)),r.register(this.overlayName,this.container,this.close.bind(this))}return e.prototype={open:function(){Promise.all([r.open(this.overlayName),this.dataAvailablePromise]).then(function(){this._getProperties()}.bind(this))},close:function(){r.close(this.overlayName)},setFileSize:function(e){e>0&&(this.rawFileSize=e)},setDocumentAndUrl:function(e,t){this.pdfDocument=e,this.url=t,this.resolveDataAvailable()},_getProperties:function(){r.active&&(this.pdfDocument.getDownloadInfo().then(function(e){e.length!==this.rawFileSize&&(this.setFileSize(e.length),this._updateUI(this.fields.fileSize,this._parseFileSize()))}.bind(this)),this.pdfDocument.getMetadata().then(function(e){var t={fileName:n(this.url),fileSize:this._parseFileSize(),title:e.info.Title,author:e.info.Author,subject:e.info.Subject,keywords:e.info.Keywords,creationDate:this._parseDate(e.info.CreationDate),modificationDate:this._parseDate(e.info.ModDate),creator:e.info.Creator,producer:e.info.Producer,version:e.info.PDFFormatVersion,pageCount:this.pdfDocument.numPages}
for(var i in t)this._updateUI(this.fields[i],t[i])}.bind(this)))},_updateUI:function(e,t){e&&void 0!==t&&""!==t&&(e.textContent=t)},_parseFileSize:function(){var e=this.rawFileSize,t=e/1024
if(t)return t<1024?s.get("document_properties_kb",{size_kb:(+t.toPrecision(3)).toLocaleString(),size_b:e.toLocaleString()},"{{size_kb}} KB ({{size_b}} bytes)"):s.get("document_properties_mb",{size_mb:(+(t/1024).toPrecision(3)).toLocaleString(),size_b:e.toLocaleString()},"{{size_mb}} MB ({{size_b}} bytes)")},_parseDate:function(e){var t=e
if(void 0===t)return""
"D:"===t.substring(0,2)&&(t=t.substring(2))
var i=parseInt(t.substring(0,4),10),n=parseInt(t.substring(4,6),10)-1,r=parseInt(t.substring(6,8),10),a=parseInt(t.substring(8,10),10),o=parseInt(t.substring(10,12),10),h=parseInt(t.substring(12,14),10),d=t.substring(14,15),c=parseInt(t.substring(15,17),10),l=parseInt(t.substring(18,20),10)
"-"===d?(a+=c,o+=l):"+"===d&&(a-=c,o-=l)
var u=new Date(Date.UTC(i,n,r,a,o,h)),f=u.toLocaleDateString(),g=u.toLocaleTimeString()
return s.get("document_properties_date_string",{date:f,time:g},"{{date}}, {{time}}")}},e}()
e.PDFDocumentProperties=a}(e.pdfjsWebPDFDocumentProperties={},e.pdfjsWebUIUtils,e.pdfjsWebOverlayManager)}(this),function(e,t){!function(e,t){var i=t.scrollIntoView,n={FIND_FOUND:0,FIND_NOTFOUND:1,FIND_WRAPPED:2,FIND_PENDING:3},s={"‘":"'","’":"'","‚":"'","‛":"'","“":'"',"”":'"',"„":'"',"‟":'"',"¼":"1/4","½":"1/2","¾":"3/4"},r=function(){function e(e){this.pdfViewer=e.pdfViewer||null,this.onUpdateResultsCount=null,this.onUpdateState=null,this.reset()
var t=Object.keys(s).join("")
this.normalizationRegex=new RegExp("["+t+"]","g")}return e.prototype={reset:function(){this.startedTextExtraction=!1,this.extractTextPromises=[],this.pendingFindMatches=Object.create(null),this.active=!1,this.pageContents=[],this.pageMatches=[],this.pageMatchesLength=null,this.matchCount=0,this.selected={pageIdx:-1,matchIdx:-1},this.offset={pageIdx:null,matchIdx:null},this.pagesToSearch=null,this.resumePageIdx=null,this.state=null,this.dirtyMatch=!1,this.findTimeout=null,this.firstPagePromise=new Promise(function(e){this.resolveFirstPage=e}.bind(this))},normalize:function(e){return e.replace(this.normalizationRegex,function(e){return s[e]})},_prepareMatches:function(e,t,i){var n,s
for(e.sort(function(e,t){return e.match===t.match?e.matchLength-t.matchLength:e.match-t.match}),n=0,s=e.length;n<s;n++)(function(e,t){var i,n,s
if(i=e[t],s=e[t+1],t<e.length-1&&i.match===s.match)return i.skipped=!0,!0
for(var r=t-1;r>=0;r--)if(n=e[r],!n.skipped){if(n.match+n.matchLength<i.match)break
if(n.match+n.matchLength>=i.match+i.matchLength)return i.skipped=!0,!0}return!1})(e,n)||(t.push(e[n].match),i.push(e[n].matchLength))},calcFindPhraseMatch:function(e,t,i){for(var n=[],s=e.length,r=-s;;){if(-1===(r=i.indexOf(e,r+s)))break
n.push(r)}this.pageMatches[t]=n},calcFindWordMatch:function(e,t,i){for(var n,s,r,a=[],o=e.match(/\S+/g),h=0,d=o.length;h<d;h++)for(n=o[h],s=n.length,r=-s;;){if(-1===(r=i.indexOf(n,r+s)))break
a.push({match:r,matchLength:s,skipped:!1})}this.pageMatchesLength||(this.pageMatchesLength=[]),this.pageMatchesLength[t]=[],this.pageMatches[t]=[],this._prepareMatches(a,this.pageMatches[t],this.pageMatchesLength[t])},calcFindMatch:function(e){var t=this.normalize(this.pageContents[e]),i=this.normalize(this.state.query),n=this.state.caseSensitive,s=this.state.phraseSearch
0!==i.length&&(n||(t=t.toLowerCase(),i=i.toLowerCase()),s?this.calcFindPhraseMatch(i,e,t):this.calcFindWordMatch(i,e,t),this.updatePage(e),this.resumePageIdx===e&&(this.resumePageIdx=null,this.nextPageMatch()),this.pageMatches[e].length>0&&(this.matchCount+=this.pageMatches[e].length,this.updateUIResultsCount()))},extractText:function(){function e(i){s.pdfViewer.getPageTextContent(i).then(function(n){for(var r=n.items,a=[],o=0,h=r.length;o<h;o++)a.push(r[o].str)
s.pageContents.push(a.join("")),t[i](i),i+1<s.pdfViewer.pagesCount&&e(i+1)})}if(!this.startedTextExtraction){this.startedTextExtraction=!0,this.pageContents=[]
for(var t=[],i=this.pdfViewer.pagesCount,n=0;n<i;n++)this.extractTextPromises.push(new Promise(function(e){t.push(e)}))
var s=this
e(0)}},executeCommand:function(e,t){null!==this.state&&"findagain"===e||(this.dirtyMatch=!0),this.state=t,this.updateUIState(n.FIND_PENDING),this.firstPagePromise.then(function(){this.extractText(),clearTimeout(this.findTimeout),"find"===e?this.findTimeout=setTimeout(this.nextMatch.bind(this),250):this.nextMatch()}.bind(this))},updatePage:function(e){this.selected.pageIdx===e&&(this.pdfViewer.currentPageNumber=e+1)
var t=this.pdfViewer.getPageView(e)
t.textLayer&&t.textLayer.updateMatches()},nextMatch:function(){var e=this.state.findPrevious,t=this.pdfViewer.currentPageNumber-1,i=this.pdfViewer.pagesCount
if(this.active=!0,this.dirtyMatch){this.dirtyMatch=!1,this.selected.pageIdx=this.selected.matchIdx=-1,this.offset.pageIdx=t,this.offset.matchIdx=null,this.hadMatch=!1,this.resumePageIdx=null,this.pageMatches=[],this.matchCount=0,this.pageMatchesLength=null
for(var s=this,r=0;r<i;r++)this.updatePage(r),r in this.pendingFindMatches||(this.pendingFindMatches[r]=!0,this.extractTextPromises[r].then(function(e){delete s.pendingFindMatches[e],s.calcFindMatch(e)}))}if(""===this.state.query)return void this.updateUIState(n.FIND_FOUND)
if(!this.resumePageIdx){var a=this.offset
if(this.pagesToSearch=i,null!==a.matchIdx){var o=this.pageMatches[a.pageIdx].length
if(!e&&a.matchIdx+1<o||e&&a.matchIdx>0)return this.hadMatch=!0,a.matchIdx=e?a.matchIdx-1:a.matchIdx+1,void this.updateMatch(!0)
this.advanceOffsetPage(e)}this.nextPageMatch()}},matchesReady:function(e){var t=this.offset,i=e.length,n=this.state.findPrevious
return i?(this.hadMatch=!0,t.matchIdx=n?i-1:0,this.updateMatch(!0),!0):(this.advanceOffsetPage(n),!!(t.wrapped&&(t.matchIdx=null,this.pagesToSearch<0))&&(this.updateMatch(!1),!0))},updateMatchPosition:function(e,t,n,s){if(this.selected.matchIdx===t&&this.selected.pageIdx===e){var r={top:-50,left:-400}
i(n[s],r,!0)}},nextPageMatch:function(){null!==this.resumePageIdx&&console.error("There can only be one pending page.")
do{var e=this.offset.pageIdx,t=this.pageMatches[e]
if(!t){this.resumePageIdx=e
break}}while(!this.matchesReady(t))},advanceOffsetPage:function(e){var t=this.offset,i=this.extractTextPromises.length
t.pageIdx=e?t.pageIdx-1:t.pageIdx+1,t.matchIdx=null,this.pagesToSearch--,(t.pageIdx>=i||t.pageIdx<0)&&(t.pageIdx=e?i-1:0,t.wrapped=!0)},updateMatch:function(e){var t=n.FIND_NOTFOUND,i=this.offset.wrapped
if(this.offset.wrapped=!1,e){var s=this.selected.pageIdx
this.selected.pageIdx=this.offset.pageIdx,this.selected.matchIdx=this.offset.matchIdx,t=i?n.FIND_WRAPPED:n.FIND_FOUND,-1!==s&&s!==this.selected.pageIdx&&this.updatePage(s)}this.updateUIState(t,this.state.findPrevious),-1!==this.selected.pageIdx&&this.updatePage(this.selected.pageIdx)},updateUIResultsCount:function(){this.onUpdateResultsCount&&this.onUpdateResultsCount(this.matchCount)},updateUIState:function(e,t){this.onUpdateState&&this.onUpdateState(e,t,this.matchCount)}},e}()
e.FindStates=n,e.PDFFindController=r}(e.pdfjsWebPDFFindController={},e.pdfjsWebUIUtils)}(this),function(e,t){!function(e,t){var i=t.normalizeWheelEventDelta,n=function(){function e(e){this.container=e.container,this.viewer=e.viewer||e.container.firstElementChild,this.pdfViewer=e.pdfViewer,this.eventBus=e.eventBus
var t=e.contextMenuItems||null
this.active=!1,this.args=null,this.contextMenuOpen=!1,this.mouseScrollTimeStamp=0,this.mouseScrollDelta=0,this.touchSwipeState=null,t&&(t.contextFirstPage.addEventListener("click",function(e){this.contextMenuOpen=!1,this.eventBus.dispatch("firstpage")}.bind(this)),t.contextLastPage.addEventListener("click",function(e){this.contextMenuOpen=!1,this.eventBus.dispatch("lastpage")}.bind(this)),t.contextPageRotateCw.addEventListener("click",function(e){this.contextMenuOpen=!1,this.eventBus.dispatch("rotatecw")}.bind(this)),t.contextPageRotateCcw.addEventListener("click",function(e){this.contextMenuOpen=!1,this.eventBus.dispatch("rotateccw")}.bind(this)))}return e.prototype={request:function(){if(this.switchInProgress||this.active||!this.viewer.hasChildNodes())return!1
if(this._addFullscreenChangeListeners(),this._setSwitchInProgress(),this._notifyStateChange(),this.container.requestFullscreen)this.container.requestFullscreen()
else if(this.container.mozRequestFullScreen)this.container.mozRequestFullScreen()
else if(this.container.webkitRequestFullscreen)this.container.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT)
else{if(!this.container.msRequestFullscreen)return!1
this.container.msRequestFullscreen()}return this.args={page:this.pdfViewer.currentPageNumber,previousScale:this.pdfViewer.currentScaleValue},!0},_mouseWheel:function(e){if(this.active){e.preventDefault()
var t=i(e),n=(new Date).getTime(),s=this.mouseScrollTimeStamp
if(!(n>s&&n-s<50)&&((this.mouseScrollDelta>0&&t<0||this.mouseScrollDelta<0&&t>0)&&this._resetMouseScrollState(),this.mouseScrollDelta+=t,Math.abs(this.mouseScrollDelta)>=.1)){var r=this.mouseScrollDelta
this._resetMouseScrollState();(r>0?this._goToPreviousPage():this._goToNextPage())&&(this.mouseScrollTimeStamp=n)}}},get isFullscreen(){return!!(document.fullscreenElement||document.mozFullScreen||document.webkitIsFullScreen||document.msFullscreenElement)},_goToPreviousPage:function(){var e=this.pdfViewer.currentPageNumber
return!(e<=1)&&(this.pdfViewer.currentPageNumber=e-1,!0)},_goToNextPage:function(){var e=this.pdfViewer.currentPageNumber
return!(e>=this.pdfViewer.pagesCount)&&(this.pdfViewer.currentPageNumber=e+1,!0)},_notifyStateChange:function(){this.eventBus.dispatch("presentationmodechanged",{source:this,active:this.active,switchInProgress:!!this.switchInProgress})},_setSwitchInProgress:function(){this.switchInProgress&&clearTimeout(this.switchInProgress),this.switchInProgress=setTimeout(function(){this._removeFullscreenChangeListeners(),delete this.switchInProgress,this._notifyStateChange()}.bind(this),1500)},_resetSwitchInProgress:function(){this.switchInProgress&&(clearTimeout(this.switchInProgress),delete this.switchInProgress)},_enter:function(){this.active=!0,this._resetSwitchInProgress(),this._notifyStateChange(),this.container.classList.add("pdfPresentationMode"),setTimeout(function(){this.pdfViewer.currentPageNumber=this.args.page,this.pdfViewer.currentScaleValue="page-fit"}.bind(this),0),this._addWindowListeners(),this._showControls(),this.contextMenuOpen=!1,this.container.setAttribute("contextmenu","viewerContextMenu"),window.getSelection().removeAllRanges()},_exit:function(){var e=this.pdfViewer.currentPageNumber
this.container.classList.remove("pdfPresentationMode"),setTimeout(function(){this.active=!1,this._removeFullscreenChangeListeners(),this._notifyStateChange(),this.pdfViewer.currentScaleValue=this.args.previousScale,this.pdfViewer.currentPageNumber=e,this.args=null}.bind(this),0),this._removeWindowListeners(),this._hideControls(),this._resetMouseScrollState(),this.container.removeAttribute("contextmenu"),this.contextMenuOpen=!1},_mouseDown:function(e){if(this.contextMenuOpen)return this.contextMenuOpen=!1,void e.preventDefault()
if(0===e.button){e.target.href&&e.target.classList.contains("internalLink")||(e.preventDefault(),this.pdfViewer.currentPageNumber+=e.shiftKey?-1:1)}},_contextMenu:function(){this.contextMenuOpen=!0},_showControls:function(){this.controlsTimeout?clearTimeout(this.controlsTimeout):this.container.classList.add("pdfPresentationModeControls"),this.controlsTimeout=setTimeout(function(){this.container.classList.remove("pdfPresentationModeControls"),delete this.controlsTimeout}.bind(this),3e3)},_hideControls:function(){this.controlsTimeout&&(clearTimeout(this.controlsTimeout),this.container.classList.remove("pdfPresentationModeControls"),delete this.controlsTimeout)},_resetMouseScrollState:function(){this.mouseScrollTimeStamp=0,this.mouseScrollDelta=0},_touchSwipe:function(e){if(this.active){var t=Math.PI/6
if(e.touches.length>1)return void(this.touchSwipeState=null)
switch(e.type){case"touchstart":this.touchSwipeState={startX:e.touches[0].pageX,startY:e.touches[0].pageY,endX:e.touches[0].pageX,endY:e.touches[0].pageY}
break
case"touchmove":if(null===this.touchSwipeState)return
this.touchSwipeState.endX=e.touches[0].pageX,this.touchSwipeState.endY=e.touches[0].pageY,e.preventDefault()
break
case"touchend":if(null===this.touchSwipeState)return
var i=0,n=this.touchSwipeState.endX-this.touchSwipeState.startX,s=this.touchSwipeState.endY-this.touchSwipeState.startY,r=Math.abs(Math.atan2(s,n))
Math.abs(n)>50&&(r<=t||r>=Math.PI-t)?i=n:Math.abs(s)>50&&Math.abs(r-Math.PI/2)<=t&&(i=s),i>0?this._goToPreviousPage():i<0&&this._goToNextPage()}}},_addWindowListeners:function(){this.showControlsBind=this._showControls.bind(this),this.mouseDownBind=this._mouseDown.bind(this),this.mouseWheelBind=this._mouseWheel.bind(this),this.resetMouseScrollStateBind=this._resetMouseScrollState.bind(this),this.contextMenuBind=this._contextMenu.bind(this),this.touchSwipeBind=this._touchSwipe.bind(this),window.addEventListener("mousemove",this.showControlsBind),window.addEventListener("mousedown",this.mouseDownBind),window.addEventListener("wheel",this.mouseWheelBind),window.addEventListener("keydown",this.resetMouseScrollStateBind),window.addEventListener("contextmenu",this.contextMenuBind),window.addEventListener("touchstart",this.touchSwipeBind),window.addEventListener("touchmove",this.touchSwipeBind),window.addEventListener("touchend",this.touchSwipeBind)},_removeWindowListeners:function(){window.removeEventListener("mousemove",this.showControlsBind),window.removeEventListener("mousedown",this.mouseDownBind),window.removeEventListener("wheel",this.mouseWheelBind),window.removeEventListener("keydown",this.resetMouseScrollStateBind),window.removeEventListener("contextmenu",this.contextMenuBind),window.removeEventListener("touchstart",this.touchSwipeBind),window.removeEventListener("touchmove",this.touchSwipeBind),window.removeEventListener("touchend",this.touchSwipeBind),delete this.showControlsBind,delete this.mouseDownBind,delete this.mouseWheelBind,delete this.resetMouseScrollStateBind,delete this.contextMenuBind,delete this.touchSwipeBind},_fullscreenChange:function(){this.isFullscreen?this._enter():this._exit()},_addFullscreenChangeListeners:function(){this.fullscreenChangeBind=this._fullscreenChange.bind(this),window.addEventListener("fullscreenchange",this.fullscreenChangeBind),window.addEventListener("mozfullscreenchange",this.fullscreenChangeBind),window.addEventListener("webkitfullscreenchange",this.fullscreenChangeBind),window.addEventListener("MSFullscreenChange",this.fullscreenChangeBind)},_removeFullscreenChangeListeners:function(){window.removeEventListener("fullscreenchange",this.fullscreenChangeBind),window.removeEventListener("mozfullscreenchange",this.fullscreenChangeBind),window.removeEventListener("webkitfullscreenchange",this.fullscreenChangeBind),window.removeEventListener("MSFullscreenChange",this.fullscreenChangeBind),delete this.fullscreenChangeBind}},e}()
e.PDFPresentationMode=n}(e.pdfjsWebPDFPresentationMode={},e.pdfjsWebUIUtils)}(this),function(e,t){!function(e,t,i){var n=t.mozL10n,s=t.getOutputScale,r=i.RenderingStates,a=98,o=1,h=function(){function e(e,i){var n=t.tempImageCache
n||(n=document.createElement("canvas"),t.tempImageCache=n),n.width=e,n.height=i,n.mozOpaque=!0
var s=n.getContext("2d",{alpha:!1})
return s.save(),s.fillStyle="rgb(255, 255, 255)",s.fillRect(0,0,e,i),s.restore(),n}function t(e){var t=e.container,i=e.id,s=e.defaultViewport,h=e.linkService,d=e.renderingQueue,c=e.disableCanvasToImageConversion||!1
this.id=i,this.renderingId="thumbnail"+i,this.pageLabel=null,this.pdfPage=null,this.rotation=0,this.viewport=s,this.pdfPageRotate=s.rotation,this.linkService=h,this.renderingQueue=d,this.renderTask=null,this.renderingState=r.INITIAL,this.resume=null,this.disableCanvasToImageConversion=c,this.pageWidth=this.viewport.width,this.pageHeight=this.viewport.height,this.pageRatio=this.pageWidth/this.pageHeight,this.canvasWidth=a,this.canvasHeight=this.canvasWidth/this.pageRatio|0,this.scale=this.canvasWidth/this.pageWidth
var l=document.createElement("a")
l.href=h.getAnchorUrl("#page="+i),l.title=n.get("thumb_page_title",{page:i},"Page {{page}}"),l.onclick=function(){return h.page=i,!1},this.anchor=l
var u=document.createElement("div")
u.className="thumbnail",u.setAttribute("data-page-number",this.id),this.div=u,1===i&&u.classList.add("selected")
var f=document.createElement("div")
f.className="thumbnailSelectionRing"
var g=2*o
f.style.width=this.canvasWidth+g+"px",f.style.height=this.canvasHeight+g+"px",this.ring=f,u.appendChild(f),l.appendChild(u),t.appendChild(l)}return t.prototype={setPdfPage:function(e){this.pdfPage=e,this.pdfPageRotate=e.rotate
var t=(this.rotation+this.pdfPageRotate)%360
this.viewport=e.getViewport(1,t),this.reset()},reset:function(){this.cancelRendering(),this.pageWidth=this.viewport.width,this.pageHeight=this.viewport.height,this.pageRatio=this.pageWidth/this.pageHeight,this.canvasHeight=this.canvasWidth/this.pageRatio|0,this.scale=this.canvasWidth/this.pageWidth,this.div.removeAttribute("data-loaded")
for(var e=this.ring,t=e.childNodes,i=t.length-1;i>=0;i--)e.removeChild(t[i])
var n=2*o
e.style.width=this.canvasWidth+n+"px",e.style.height=this.canvasHeight+n+"px",this.canvas&&(this.canvas.width=0,this.canvas.height=0,delete this.canvas),this.image&&(this.image.removeAttribute("src"),delete this.image)},update:function(e){void 0!==e&&(this.rotation=e)
var t=(this.rotation+this.pdfPageRotate)%360
this.viewport=this.viewport.clone({scale:1,rotation:t}),this.reset()},cancelRendering:function(){this.renderTask&&(this.renderTask.cancel(),this.renderTask=null),this.renderingState=r.INITIAL,this.resume=null},_getPageDrawContext:function(e){var t=document.createElement("canvas")
this.canvas=t,t.mozOpaque=!0
var i=t.getContext("2d",{alpha:!1}),n=s(i)
return t.width=this.canvasWidth*n.sx|0,t.height=this.canvasHeight*n.sy|0,t.style.width=this.canvasWidth+"px",t.style.height=this.canvasHeight+"px",!e&&n.scaled&&i.scale(n.sx,n.sy),i},_convertCanvasToImage:function(){if(this.canvas&&this.renderingState===r.FINISHED){var e=this.renderingId,t=n.get("thumb_page_canvas",{page:this.pageId},"Thumbnail of Page {{page}}")
if(this.disableCanvasToImageConversion)return this.canvas.id=e,this.canvas.className="thumbnailImage",this.canvas.setAttribute("aria-label",t),this.div.setAttribute("data-loaded",!0),void this.ring.appendChild(this.canvas)
var i=document.createElement("img")
i.id=e,i.className="thumbnailImage",i.setAttribute("aria-label",t),i.style.width=this.canvasWidth+"px",i.style.height=this.canvasHeight+"px",i.src=this.canvas.toDataURL(),this.image=i,this.div.setAttribute("data-loaded",!0),this.ring.appendChild(i),this.canvas.width=0,this.canvas.height=0,delete this.canvas}},draw:function(){function e(e){if(c===s.renderTask&&(s.renderTask=null),"cancelled"===e)return void i(e)
s.renderingState=r.FINISHED,s._convertCanvasToImage(),e?i(e):t(void 0)}if(this.renderingState!==r.INITIAL)return console.error("Must be in new state before drawing"),Promise.resolve(void 0)
this.renderingState=r.RUNNING
var t,i,n=new Promise(function(e,n){t=e,i=n}),s=this,a=this._getPageDrawContext(),o=this.viewport.clone({scale:this.scale}),h=function(e){if(!s.renderingQueue.isHighestPriority(s))return s.renderingState=r.PAUSED,void(s.resume=function(){s.renderingState=r.RUNNING,e()})
e()},d={canvasContext:a,viewport:o},c=this.renderTask=this.pdfPage.render(d)
return c.onContinue=h,c.promise.then(function(){e(null)},function(t){e(t)}),n},setImage:function(t){if(this.renderingState===r.INITIAL){var i=t.canvas
if(i){this.pdfPage||this.setPdfPage(t.pdfPage),this.renderingState=r.FINISHED
var n=this._getPageDrawContext(!0),s=n.canvas
if(i.width<=2*s.width)return n.drawImage(i,0,0,i.width,i.height,0,0,s.width,s.height),void this._convertCanvasToImage()
for(var a=s.width<<3,o=s.height<<3,h=e(a,o),d=h.getContext("2d");a>i.width||o>i.height;)a>>=1,o>>=1
for(d.drawImage(i,0,0,i.width,i.height,0,0,a,o);a>2*s.width;)d.drawImage(h,0,0,a,o,0,0,a>>1,o>>1),a>>=1,o>>=1
n.drawImage(h,0,0,a,o,0,0,s.width,s.height),this._convertCanvasToImage()}}},get pageId(){return null!==this.pageLabel?this.pageLabel:this.id},setPageLabel:function(e){if(this.pageLabel="string"==typeof e?e:null,this.anchor.title=n.get("thumb_page_title",{page:this.pageId},"Page {{page}}"),this.renderingState===r.FINISHED){var t=n.get("thumb_page_canvas",{page:this.pageId},"Thumbnail of Page {{page}}")
this.image?this.image.setAttribute("aria-label",t):this.disableCanvasToImageConversion&&this.canvas&&this.canvas.setAttribute("aria-label",t)}}},t}()
h.tempImageCache=null,e.PDFThumbnailView=h}(e.pdfjsWebPDFThumbnailView={},e.pdfjsWebUIUtils,e.pdfjsWebPDFRenderingQueue)}(this),function(e,t){!function(e,t){var i=t.SCROLLBAR_PADDING,n=t.mozL10n,s=function(){function e(e,t,i){this.toolbar=e.toolbar,this.toggleButton=e.toggleButton,this.toolbarButtonContainer=e.toolbarButtonContainer,this.buttons=[{element:e.presentationModeButton,eventName:"presentationmode",close:!0},{element:e.openFileButton,eventName:"openfile",close:!0},{element:e.printButton,eventName:"print",close:!0},{element:e.downloadButton,eventName:"download",close:!0},{element:e.viewBookmarkButton,eventName:null,close:!0},{element:e.firstPageButton,eventName:"firstpage",close:!0},{element:e.lastPageButton,eventName:"lastpage",close:!0},{element:e.pageRotateCwButton,eventName:"rotatecw",close:!1},{element:e.pageRotateCcwButton,eventName:"rotateccw",close:!1},{element:e.toggleHandToolButton,eventName:"togglehandtool",close:!0},{element:e.documentPropertiesButton,eventName:"documentproperties",close:!0}],this.items={firstPage:e.firstPageButton,lastPage:e.lastPageButton,pageRotateCw:e.pageRotateCwButton,pageRotateCcw:e.pageRotateCcwButton},this.mainContainer=t,this.eventBus=i,this.opened=!1,this.containerHeight=null,this.previousContainerHeight=null,this.reset(),this._bindClickListeners(),this._bindHandToolListener(e.toggleHandToolButton),this.eventBus.on("resize",this._setMaxHeight.bind(this))}return e.prototype={get isOpen(){return this.opened},setPageNumber:function(e){this.pageNumber=e,this._updateUIState()},setPagesCount:function(e){this.pagesCount=e,this._updateUIState()},reset:function(){this.pageNumber=0,this.pagesCount=0,this._updateUIState()},_updateUIState:function(){var e=this.items
e.firstPage.disabled=this.pageNumber<=1,e.lastPage.disabled=this.pageNumber>=this.pagesCount,e.pageRotateCw.disabled=0===this.pagesCount,e.pageRotateCcw.disabled=0===this.pagesCount},_bindClickListeners:function(){this.toggleButton.addEventListener("click",this.toggle.bind(this))
for(var e in this.buttons){var t=this.buttons[e].element,i=this.buttons[e].eventName,n=this.buttons[e].close
t.addEventListener("click",function(e,t){null!==e&&this.eventBus.dispatch(e,{source:this}),t&&this.close()}.bind(this,i,n))}},_bindHandToolListener:function(e){var t=!1
this.eventBus.on("handtoolchanged",function(i){t!==i.isActive&&(t=i.isActive,t?(e.title=n.get("hand_tool_disable.title",null,"Disable hand tool"),e.firstElementChild.textContent=n.get("hand_tool_disable_label",null,"Disable hand tool")):(e.title=n.get("hand_tool_enable.title",null,"Enable hand tool"),e.firstElementChild.textContent=n.get("hand_tool_enable_label",null,"Enable hand tool")))})},open:function(){this.opened||(this.opened=!0,this._setMaxHeight(),this.toggleButton.classList.add("toggled"),this.toolbar.classList.remove("hidden"))},close:function(){this.opened&&(this.opened=!1,this.toolbar.classList.add("hidden"),this.toggleButton.classList.remove("toggled"))},toggle:function(){this.opened?this.close():this.open()},_setMaxHeight:function(){this.opened&&(this.containerHeight=this.mainContainer.clientHeight,this.containerHeight!==this.previousContainerHeight&&(this.toolbarButtonContainer.setAttribute("style","max-height: "+(this.containerHeight-i)+"px;"),this.previousContainerHeight=this.containerHeight))}},e}()
e.SecondaryToolbar=s}(e.pdfjsWebSecondaryToolbar={},e.pdfjsWebUIUtils)}(this),function(e,t){!function(e,t){var i=t.mozL10n,n=t.noContextMenuHandler,s=t.animationStarted,r=t.localized,a=t.DEFAULT_SCALE_VALUE,o=t.DEFAULT_SCALE,h=t.MIN_SCALE,d=t.MAX_SCALE,c=function(){function e(e,t,i){this.toolbar=e.container,this.mainContainer=t,this.eventBus=i,this.items=e,this._wasLocalized=!1,this.reset(),this._bindListeners()}return e.prototype={setPageNumber:function(e,t){this.pageNumber=e,this.pageLabel=t,this._updateUIState(!1)},setPagesCount:function(e,t){this.pagesCount=e,this.hasPageLabels=t,this._updateUIState(!0)},setPageScale:function(e,t){this.pageScaleValue=e,this.pageScale=t,this._updateUIState(!1)},reset:function(){this.pageNumber=0,this.pageLabel=null,this.hasPageLabels=!1,this.pagesCount=0,this.pageScaleValue=a,this.pageScale=o,this._updateUIState(!0)},_bindListeners:function(){var e=this.eventBus,t=this,i=this.items
i.previous.addEventListener("click",function(){e.dispatch("previouspage")}),i.next.addEventListener("click",function(){e.dispatch("nextpage")}),i.zoomIn.addEventListener("click",function(){e.dispatch("zoomin")}),i.zoomOut.addEventListener("click",function(){e.dispatch("zoomout")}),i.pageNumber.addEventListener("click",function(){this.select()}),i.pageNumber.addEventListener("change",function(){e.dispatch("pagenumberchanged",{source:t,value:this.value})}),i.scaleSelect.addEventListener("change",function(){"custom"!==this.value&&e.dispatch("scalechanged",{source:t,value:this.value})}),i.presentationModeButton.addEventListener("click",function(t){e.dispatch("presentationmode")}),i.openFile.addEventListener("click",function(t){e.dispatch("openfile")}),i.print.addEventListener("click",function(t){e.dispatch("print")}),i.download.addEventListener("click",function(t){e.dispatch("download")}),i.scaleSelect.oncontextmenu=n,r.then(this._localized.bind(this))},_localized:function(){this._wasLocalized=!0,this._adjustScaleWidth(),this._updateUIState(!0)},_updateUIState:function(e){if(this._wasLocalized){var t=this.pageNumber,n=(this.pageScaleValue||this.pageScale).toString(),s=this.pageScale,r=this.items,a=this.pagesCount
e&&(this.hasPageLabels?r.pageNumber.type="text":(r.pageNumber.type="number",r.numPages.textContent=i.get("of_pages",{pagesCount:a},"of {{pagesCount}}")),r.pageNumber.max=a),this.hasPageLabels?(r.pageNumber.value=this.pageLabel,r.numPages.textContent=i.get("page_of_pages",{pageNumber:t,pagesCount:a},"({{pageNumber}} of {{pagesCount}})")):r.pageNumber.value=t,r.previous.disabled=t<=1,r.next.disabled=t>=a,r.zoomOut.disabled=s<=h,r.zoomIn.disabled=s>=d,function(e,t){for(var n=r.scaleSelect.options,s=!1,a=0,o=n.length;a<o;a++){var h=n[a]
h.value===e?(h.selected=!0,s=!0):h.selected=!1}if(!s){var d=Math.round(1e4*t)/100
r.customScaleOption.textContent=i.get("page_scale_percent",{scale:d},"{{scale}}%"),r.customScaleOption.selected=!0}}(n,s)}},updateLoadingIndicatorState:function(e){var t=this.items.pageNumber
e?t.classList.add("visiblePageIsLoading"):t.classList.remove("visiblePageIsLoading")},_adjustScaleWidth:function(){var e=this.items.scaleSelectContainer,t=this.items.scaleSelect
s.then(function(){if(0===e.clientWidth&&e.setAttribute("style","display: inherit;"),e.clientWidth>0){t.setAttribute("style","min-width: inherit;")
var i=t.clientWidth+8
t.setAttribute("style","min-width: "+(i+22)+"px;"),e.setAttribute("style","min-width: "+i+"px; max-width: "+i+"px;")}})}},e}()
e.Toolbar=c}(e.pdfjsWebToolbar={},e.pdfjsWebUIUtils)}(this),function(e,t){!function(e,t,i){var n=t.mozL10n,s=i.FindStates,r=function(){function e(e){if(this.opened=!1,this.bar=e.bar||null,this.toggleButton=e.toggleButton||null,this.findField=e.findField||null,this.highlightAll=e.highlightAllCheckbox||null,this.caseSensitive=e.caseSensitiveCheckbox||null,this.findMsg=e.findMsg||null,this.findResultsCount=e.findResultsCount||null,this.findStatusIcon=e.findStatusIcon||null,this.findPreviousButton=e.findPreviousButton||null,this.findNextButton=e.findNextButton||null,this.findController=e.findController||null,this.eventBus=e.eventBus,null===this.findController)throw new Error("PDFFindBar cannot be used without a PDFFindController instance.")
var t=this
this.toggleButton.addEventListener("click",function(){t.toggle()}),this.findField.addEventListener("input",function(){t.dispatchEvent("")}),this.bar.addEventListener("keydown",function(e){switch(e.keyCode){case 13:e.target===t.findField&&t.dispatchEvent("again",e.shiftKey)
break
case 27:t.close()}}),this.findPreviousButton.addEventListener("click",function(){t.dispatchEvent("again",!0)}),this.findNextButton.addEventListener("click",function(){t.dispatchEvent("again",!1)}),this.highlightAll.addEventListener("click",function(){t.dispatchEvent("highlightallchange")}),this.caseSensitive.addEventListener("click",function(){t.dispatchEvent("casesensitivitychange")})}return e.prototype={reset:function(){this.updateUIState()},dispatchEvent:function(e,t){this.eventBus.dispatch("find",{source:this,type:e,query:this.findField.value,caseSensitive:this.caseSensitive.checked,phraseSearch:!0,highlightAll:this.highlightAll.checked,findPrevious:t})},updateUIState:function(e,t,i){var r=!1,a="",o=""
switch(e){case s.FIND_FOUND:break
case s.FIND_PENDING:o="pending"
break
case s.FIND_NOTFOUND:a=n.get("find_not_found",null,"Phrase not found"),r=!0
break
case s.FIND_WRAPPED:a=t?n.get("find_reached_top",null,"Reached top of document, continued from bottom"):n.get("find_reached_bottom",null,"Reached end of document, continued from top")}r?this.findField.classList.add("notFound"):this.findField.classList.remove("notFound"),this.findField.setAttribute("data-status",o),this.findMsg.textContent=a,this.updateResultsCount(i)},updateResultsCount:function(e){if(this.findResultsCount){if(!e)return void this.findResultsCount.classList.add("hidden")
this.findResultsCount.textContent=e.toLocaleString(),this.findResultsCount.classList.remove("hidden")}},open:function(){this.opened||(this.opened=!0,this.toggleButton.classList.add("toggled"),this.bar.classList.remove("hidden")),this.findField.select(),this.findField.focus()},close:function(){this.opened&&(this.opened=!1,this.toggleButton.classList.remove("toggled"),this.bar.classList.add("hidden"),this.findController.active=!1)},toggle:function(){this.opened?this.close():this.open()}},e}()
e.PDFFindBar=r}(e.pdfjsWebPDFFindBar={},e.pdfjsWebUIUtils,e.pdfjsWebPDFFindController)}(this),function(e,t){!function(e,t){function i(e){this.linkService=e.linkService,this.eventBus=e.eventBus||t.getGlobalEventBus(),this.initialized=!1,this.initialDestination=null,this.initialBookmark=null}i.prototype={initialize:function(e){function t(){r.previousHash=window.location.hash.slice(1),r._pushToHistory({hash:r.previousHash},!1,!0),r._updatePreviousBookmark()}function i(e,t){function i(){window.removeEventListener("popstate",i),window.addEventListener("popstate",n),r._pushToHistory(e,!1,!0),history.forward()}function n(){window.removeEventListener("popstate",n),r.allowHashChange=!0,r.historyUnlocked=!0,t()}r.historyUnlocked=!1,r.allowHashChange=!1,window.addEventListener("popstate",i),history.back()}function n(){var e=r._getPreviousParams(null,!0)
if(e){var t=!r.current.dest&&r.current.hash!==r.previousHash
r._pushToHistory(e,!1,t),r._updatePreviousBookmark()}window.removeEventListener("beforeunload",n)}this.initialized=!0,this.reInitialized=!1,this.allowHashChange=!0,this.historyUnlocked=!0,this.isViewerInPresentationMode=!1,this.previousHash=window.location.hash.substring(1),this.currentBookmark="",this.currentPage=0,this.updatePreviousBookmark=!1,this.previousBookmark="",this.previousPage=0,this.nextHashParam="",this.fingerprint=e,this.currentUid=this.uid=0,this.current={}
var s=window.history.state
this._isStateObjectDefined(s)?(s.target.dest?this.initialDestination=s.target.dest:this.initialBookmark=s.target.hash,this.currentUid=s.uid,this.uid=s.uid+1,this.current=s.target):(s&&s.fingerprint&&this.fingerprint!==s.fingerprint&&(this.reInitialized=!0),this._pushOrReplaceState({fingerprint:this.fingerprint},!0))
var r=this
window.addEventListener("popstate",function(e){if(r.historyUnlocked){if(e.state)return void r._goTo(e.state)
if(0===r.uid){i(r.previousHash&&r.currentBookmark&&r.previousHash!==r.currentBookmark?{hash:r.currentBookmark,page:r.currentPage}:{page:1},function(){t()})}else t()}}),window.addEventListener("beforeunload",n),window.addEventListener("pageshow",function(e){window.addEventListener("beforeunload",n)}),r.eventBus.on("presentationmodechanged",function(e){r.isViewerInPresentationMode=e.active})},clearHistoryState:function(){this._pushOrReplaceState(null,!0)},_isStateObjectDefined:function(e){return!!(e&&e.uid>=0&&e.fingerprint&&this.fingerprint===e.fingerprint&&e.target&&e.target.hash)},_pushOrReplaceState:function(e,t){t?window.history.replaceState(e,"",document.URL):window.history.pushState(e,"",document.URL)},get isHashChangeUnlocked(){return!this.initialized||this.allowHashChange},_updatePreviousBookmark:function(){this.updatePreviousBookmark&&this.currentBookmark&&this.currentPage&&(this.previousBookmark=this.currentBookmark,this.previousPage=this.currentPage,this.updatePreviousBookmark=!1)},updateCurrentBookmark:function(e,t){this.initialized&&(this.currentBookmark=e.substring(1),this.currentPage=0|t,this._updatePreviousBookmark())},updateNextHashParam:function(e){this.initialized&&(this.nextHashParam=e)},push:function(e,t){if(this.initialized&&this.historyUnlocked){if(e.dest&&!e.hash&&(e.hash=this.current.hash&&this.current.dest&&this.current.dest===e.dest?this.current.hash:this.linkService.getDestinationHash(e.dest).split("#")[1]),e.page&&(e.page|=0),t){var i=window.history.state.target
return i||(this._pushToHistory(e,!1),this.previousHash=window.location.hash.substring(1)),this.updatePreviousBookmark=!this.nextHashParam,void(i&&this._updatePreviousBookmark())}if(this.nextHashParam){if(this.nextHashParam===e.hash)return this.nextHashParam=null,void(this.updatePreviousBookmark=!0)
this.nextHashParam=null}e.hash?this.current.hash?this.current.hash!==e.hash?this._pushToHistory(e,!0):(!this.current.page&&e.page&&this._pushToHistory(e,!1,!0),this.updatePreviousBookmark=!0):this._pushToHistory(e,!0):this.current.page&&e.page&&this.current.page!==e.page&&this._pushToHistory(e,!0)}},_getPreviousParams:function(e,t){if(!this.currentBookmark||!this.currentPage)return null
if(this.updatePreviousBookmark&&(this.updatePreviousBookmark=!1),this.uid>0&&(!this.previousBookmark||!this.previousPage))return null
if(!this.current.dest&&!e||t){if(this.previousBookmark===this.currentBookmark)return null}else{if(!this.current.page&&!e)return null
if(this.previousPage===this.currentPage)return null}var i={hash:this.currentBookmark,page:this.currentPage}
return this.isViewerInPresentationMode&&(i.hash=null),i},_stateObj:function(e){return{fingerprint:this.fingerprint,uid:this.uid,target:e}},_pushToHistory:function(e,t,i){if(this.initialized){if(!e.hash&&e.page&&(e.hash="page="+e.page),t&&!i){var n=this._getPreviousParams()
if(n){var s=!this.current.dest&&this.current.hash!==this.previousHash
this._pushToHistory(n,!1,s)}}this._pushOrReplaceState(this._stateObj(e),i||0===this.uid),this.currentUid=this.uid++,this.current=e,this.updatePreviousBookmark=!0}},_goTo:function(e){if(this.initialized&&this.historyUnlocked&&this._isStateObjectDefined(e)){if(!this.reInitialized&&e.uid<this.currentUid){var t=this._getPreviousParams(!0)
if(t)return this._pushToHistory(this.current,!1),this._pushToHistory(t,!1),this.currentUid=e.uid,void window.history.back()}this.historyUnlocked=!1,e.target.dest?this.linkService.navigateTo(e.target.dest):this.linkService.setHash(e.target.hash),this.currentUid=e.uid,e.uid>this.uid&&(this.uid=e.uid),this.current=e.target,this.updatePreviousBookmark=!0
var i=window.location.hash.substring(1)
this.previousHash!==i&&(this.allowHashChange=!1),this.previousHash=i,this.historyUnlocked=!0}},back:function(){this.go(-1)},forward:function(){this.go(1)},go:function(e){if(this.initialized&&this.historyUnlocked){var t=window.history.state;-1===e&&t&&t.uid>0?window.history.back():1===e&&t&&t.uid<this.uid-1&&window.history.forward()}}},e.PDFHistory=i}(e.pdfjsWebPDFHistory={},e.pdfjsWebDOMEvents)}(this),function(e,t){!function(e,t,i){function n(e){return r.test(e)}var s=t.parseQueryString,r=/^\d+$/,a=function(){function e(e){e=e||{},this.eventBus=e.eventBus||i.getGlobalEventBus(),this.baseUrl=null,this.pdfDocument=null,this.pdfViewer=null,this.pdfHistory=null,this._pagesRefCache=null}function t(e){if(!(e instanceof Array))return!1
var t=e.length,i=!0
if(t<2)return!1
var n=e[0]
if(!("object"==typeof n&&"number"==typeof n.num&&(0|n.num)===n.num&&"number"==typeof n.gen&&(0|n.gen)===n.gen||"number"==typeof n&&(0|n)===n&&n>=0))return!1
var s=e[1]
if("object"!=typeof s||"string"!=typeof s.name)return!1
switch(s.name){case"XYZ":if(5!==t)return!1
break
case"Fit":case"FitB":return 2===t
case"FitH":case"FitBH":case"FitV":case"FitBV":if(3!==t)return!1
break
case"FitR":if(6!==t)return!1
i=!1
break
default:return!1}for(var r=2;r<t;r++){var a=e[r]
if(!("number"==typeof a||i&&null===a))return!1}return!0}return e.prototype={setDocument:function(e,t){this.baseUrl=t,this.pdfDocument=e,this._pagesRefCache=Object.create(null)},setViewer:function(e){this.pdfViewer=e},setHistory:function(e){this.pdfHistory=e},get pagesCount(){return this.pdfDocument?this.pdfDocument.numPages:0},get page(){return this.pdfViewer.currentPageNumber},set page(e){this.pdfViewer.currentPageNumber=e},navigateTo:function(e){var t,i="",n=this,s=function(t){var r
if(t instanceof Object)r=n._cachedPageNumber(t)
else{if((0|t)!==t)return void console.error('PDFLinkService_navigateTo: "'+t+'" is not a valid destination reference.')
r=t+1}if(r){if(r<1||r>n.pagesCount)return void console.error('PDFLinkService_navigateTo: "'+r+'" is a non-existent page number.')
n.pdfViewer.scrollPageIntoView({pageNumber:r,destArray:e}),n.pdfHistory&&n.pdfHistory.push({dest:e,hash:i,page:r})}else n.pdfDocument.getPageIndex(t).then(function(e){n.cachePageRef(e+1,t),s(t)}).catch(function(){console.error('PDFLinkService_navigateTo: "'+t+'" is not a valid page reference.')})}
"string"==typeof e?(i=e,t=this.pdfDocument.getDestination(e)):t=Promise.resolve(e),t.then(function(t){if(e=t,!(t instanceof Array))return void console.error('PDFLinkService_navigateTo: "'+t+'" is not a valid destination array.')
s(t[0])})},getDestinationHash:function(e){if("string"==typeof e)return this.getAnchorUrl("#"+(n(e)?"nameddest=":"")+escape(e))
if(e instanceof Array){var t=JSON.stringify(e)
return this.getAnchorUrl("#"+escape(t))}return this.getAnchorUrl("")},getAnchorUrl:function(e){return(this.baseUrl||"")+e},setHash:function(e){var i,r
if(e.indexOf("=")>=0){var a=s(e)
if("search"in a&&this.eventBus.dispatch("findfromurlhash",{source:this,query:a.search.replace(/"/g,""),phraseSearch:"true"===a.phrase}),"nameddest"in a)return this.pdfHistory&&this.pdfHistory.updateNextHashParam(a.nameddest),void this.navigateTo(a.nameddest)
if("page"in a&&(i=0|a.page||1),"zoom"in a){var o=a.zoom.split(","),h=o[0],d=parseFloat(h);-1===h.indexOf("Fit")?r=[null,{name:"XYZ"},o.length>1?0|o[1]:null,o.length>2?0|o[2]:null,d?d/100:h]:"Fit"===h||"FitB"===h?r=[null,{name:h}]:"FitH"===h||"FitBH"===h||"FitV"===h||"FitBV"===h?r=[null,{name:h},o.length>1?0|o[1]:null]:"FitR"===h?5!==o.length?console.error("PDFLinkService_setHash: Not enough parameters for 'FitR'."):r=[null,{name:h},0|o[1],0|o[2],0|o[3],0|o[4]]:console.error("PDFLinkService_setHash: '"+h+"' is not a valid zoom value.")}r?this.pdfViewer.scrollPageIntoView({pageNumber:i||this.page,destArray:r,allowNegativeOffset:!0}):i&&(this.page=i),"pagemode"in a&&this.eventBus.dispatch("pagemode",{source:this,mode:a.pagemode})}else{n(e)&&e<=this.pagesCount&&(console.warn('PDFLinkService_setHash: specifying a page number directly after the hash symbol (#) is deprecated, please use the "#page='+e+'" form instead.'),this.page=0|e),r=unescape(e)
try{r=JSON.parse(r),r instanceof Array||(r=r.toString())}catch(e){}if("string"==typeof r||t(r))return this.pdfHistory&&this.pdfHistory.updateNextHashParam(r),void this.navigateTo(r)
console.error("PDFLinkService_setHash: '"+unescape(e)+"' is not a valid destination.")}},executeNamedAction:function(e){switch(e){case"GoBack":this.pdfHistory&&this.pdfHistory.back()
break
case"GoForward":this.pdfHistory&&this.pdfHistory.forward()
break
case"NextPage":this.page<this.pagesCount&&this.page++
break
case"PrevPage":this.page>1&&this.page--
break
case"LastPage":this.page=this.pagesCount
break
case"FirstPage":this.page=1}this.eventBus.dispatch("namedaction",{source:this,action:e})},cachePageRef:function(e,t){var i=t.num+" "+t.gen+" R"
this._pagesRefCache[i]=e},_cachedPageNumber:function(e){var t=e.num+" "+e.gen+" R"
return this._pagesRefCache&&this._pagesRefCache[t]||null}},e}(),o=function(){function e(){}return e.prototype={get page(){return 0},set page(e){},navigateTo:function(e){},getDestinationHash:function(e){return"#"},getAnchorUrl:function(e){return"#"},setHash:function(e){},executeNamedAction:function(e){},cachePageRef:function(e,t){}},e}()
e.PDFLinkService=a,e.SimpleLinkService=o}(e.pdfjsWebPDFLinkService={},e.pdfjsWebUIUtils,e.pdfjsWebDOMEvents)}(this),function(e,t){!function(e,t,i,n,s){var r=t.CSS_UNITS,a=t.DEFAULT_SCALE,o=t.getOutputScale,h=t.approximateFraction,d=t.roundToDivide,c=t.RendererType,l=i.RenderingStates,u=function(){function e(e){var t=e.container,i=e.id,s=e.scale,r=e.defaultViewport,o=e.renderingQueue,h=e.textLayerFactory,d=e.annotationLayerFactory,u=e.enhanceTextSelection||!1,f=e.renderInteractiveForms||!1
this.id=i,this.renderingId="page"+i,this.pageLabel=null,this.rotation=0,this.scale=s||a,this.viewport=r,this.pdfPageRotate=r.rotation,this.hasRestrictedScaling=!1,this.enhanceTextSelection=u,this.renderInteractiveForms=f,this.eventBus=e.eventBus||n.getGlobalEventBus(),this.renderingQueue=o,this.textLayerFactory=h,this.annotationLayerFactory=d,this.renderer=e.renderer||c.CANVAS,this.paintTask=null,this.paintedViewportMap=new WeakMap,this.renderingState=l.INITIAL,this.resume=null,this.error=null,this.onBeforeDraw=null,this.onAfterDraw=null,this.textLayer=null,this.zoomLayer=null,this.annotationLayer=null
var g=document.createElement("div")
g.className="page",g.style.width=Math.floor(this.viewport.width)+"px",g.style.height=Math.floor(this.viewport.height)+"px",g.setAttribute("data-page-number",this.id),this.div=g,t.appendChild(g)}return e.prototype={setPdfPage:function(e){this.pdfPage=e,this.pdfPageRotate=e.rotate
var t=(this.rotation+this.pdfPageRotate)%360
this.viewport=e.getViewport(this.scale*r,t),this.stats=e.stats,this.reset()},destroy:function(){this.zoomLayer=null,this.reset(),this.pdfPage&&this.pdfPage.cleanup()},reset:function(e,t){this.cancelRendering()
var i=this.div
i.style.width=Math.floor(this.viewport.width)+"px",i.style.height=Math.floor(this.viewport.height)+"px"
for(var n=i.childNodes,s=e&&this.zoomLayer||null,r=t&&this.annotationLayer&&this.annotationLayer.div||null,a=n.length-1;a>=0;a--){var o=n[a]
s!==o&&r!==o&&i.removeChild(o)}i.removeAttribute("data-loaded"),r?this.annotationLayer.hide():this.annotationLayer=null,this.canvas&&!s&&(this.paintedViewportMap.delete(this.canvas),this.canvas.width=0,this.canvas.height=0,delete this.canvas),this.svg&&(this.paintedViewportMap.delete(this.svg),delete this.svg),this.loadingIconDiv=document.createElement("div"),this.loadingIconDiv.className="loadingIcon",i.appendChild(this.loadingIconDiv)},update:function(e,t){this.scale=e||this.scale,void 0!==t&&(this.rotation=t)
var i=(this.rotation+this.pdfPageRotate)%360
if(this.viewport=this.viewport.clone({scale:this.scale*r,rotation:i}),this.svg)return this.cssTransform(this.svg,!0),void this.eventBus.dispatch("pagerendered",{source:this,pageNumber:this.id,cssTransform:!0})
var n=!1
if(this.canvas&&s.PDFJS.maxCanvasPixels>0){var a=this.outputScale;(Math.floor(this.viewport.width)*a.sx|0)*(Math.floor(this.viewport.height)*a.sy|0)>s.PDFJS.maxCanvasPixels&&(n=!0)}if(this.canvas){if(s.PDFJS.useOnlyCssZoom||this.hasRestrictedScaling&&n)return this.cssTransform(this.canvas,!0),void this.eventBus.dispatch("pagerendered",{source:this,pageNumber:this.id,cssTransform:!0})
this.zoomLayer||(this.zoomLayer=this.canvas.parentNode,this.zoomLayer.style.position="absolute")}this.zoomLayer&&this.cssTransform(this.zoomLayer.firstChild),this.reset(!0,!0)},cancelRendering:function(){this.paintTask&&(this.paintTask.cancel(),this.paintTask=null),this.renderingState=l.INITIAL,this.resume=null,this.textLayer&&(this.textLayer.cancel(),this.textLayer=null)},updatePosition:function(){this.textLayer&&this.textLayer.render(200)},cssTransform:function(e,t){var i=s.CustomStyle,n=this.viewport.width,r=this.viewport.height,a=this.div
e.style.width=e.parentNode.style.width=a.style.width=Math.floor(n)+"px",e.style.height=e.parentNode.style.height=a.style.height=Math.floor(r)+"px"
var o=this.viewport.rotation-this.paintedViewportMap.get(e).rotation,h=Math.abs(o),d=1,c=1
90!==h&&270!==h||(d=r/n,c=n/r)
var l="rotate("+o+"deg) scale("+d+","+c+")"
if(i.setProp("transform",e,l),this.textLayer){var u=this.textLayer.viewport,f=this.viewport.rotation-u.rotation,g=Math.abs(f),p=n/u.width
90!==g&&270!==g||(p=n/u.height)
var v,m,b=this.textLayer.textLayerDiv
switch(g){case 0:v=m=0
break
case 90:v=0,m="-"+b.style.height
break
case 180:v="-"+b.style.width,m="-"+b.style.height
break
case 270:v="-"+b.style.width,m=0
break
default:console.error("Bad rotation value.")}i.setProp("transform",b,"rotate("+g+"deg) scale("+p+", "+p+") translate("+v+", "+m+")"),i.setProp("transformOrigin",b,"0% 0%")}t&&this.annotationLayer&&this.annotationLayer.render(this.viewport,"display")},get width(){return this.viewport.width},get height(){return this.viewport.height},getPagePoint:function(e,t){return this.viewport.convertToPdfPoint(e,t)},draw:function(){this.renderingState!==l.INITIAL&&(console.error("Must be in new state before drawing"),this.reset()),this.renderingState=l.RUNNING
var e=this,t=this.pdfPage,i=(this.viewport,this.div),n=document.createElement("div")
n.style.width=i.style.width,n.style.height=i.style.height,n.classList.add("canvasWrapper"),this.annotationLayer&&this.annotationLayer.div?i.insertBefore(n,this.annotationLayer.div):i.appendChild(n)
var s=null,r=null
this.textLayerFactory&&(s=document.createElement("div"),s.className="textLayer",s.style.width=n.style.width,s.style.height=n.style.height,this.annotationLayer&&this.annotationLayer.div?i.insertBefore(s,this.annotationLayer.div):i.appendChild(s),r=this.textLayerFactory.createTextLayerBuilder(s,this.id-1,this.viewport,this.enhanceTextSelection)),this.textLayer=r
var a=null
this.renderingQueue&&(a=function(t){if(!e.renderingQueue.isHighestPriority(e))return e.renderingState=l.PAUSED,void(e.resume=function(){e.renderingState=l.RUNNING,t()})
t()})
var o=function(n){if(h===e.paintTask&&(e.paintTask=null),"cancelled"===n)return e.error=null,Promise.resolve(void 0)
if(e.renderingState=l.FINISHED,e.loadingIconDiv&&(i.removeChild(e.loadingIconDiv),delete e.loadingIconDiv),e.zoomLayer){var s=e.zoomLayer.firstChild
e.paintedViewportMap.delete(s),s.width=0,s.height=0,i.contains(e.zoomLayer)&&i.removeChild(e.zoomLayer),e.zoomLayer=null}return e.error=n,e.stats=t.stats,e.onAfterDraw&&e.onAfterDraw(),e.eventBus.dispatch("pagerendered",{source:e,pageNumber:e.id,cssTransform:!1}),n?Promise.reject(n):Promise.resolve(void 0)},h=this.renderer===c.SVG?this.paintOnSvg(n):this.paintOnCanvas(n)
h.onRenderContinue=a,this.paintTask=h
var d=h.promise.then(function(){return o(null).then(function(){r&&t.getTextContent({normalizeWhitespace:!0}).then(function(e){r.setTextContent(e),r.render(200)})})},function(e){return o(e)})
return this.annotationLayerFactory&&(this.annotationLayer||(this.annotationLayer=this.annotationLayerFactory.createAnnotationLayerBuilder(i,t,this.renderInteractiveForms)),this.annotationLayer.render(this.viewport,"display")),i.setAttribute("data-loaded",!0),this.onBeforeDraw&&this.onBeforeDraw(),d},paintOnCanvas:function(e){var t,i,n=new Promise(function(e,n){t=e,i=n}),a={promise:n,onRenderContinue:function(e){e()},cancel:function(){L.cancel()}},c=(this.pdfPage,this.viewport),l=document.createElement("canvas")
l.id="page"+this.id,l.setAttribute("hidden","hidden")
var u=!0,f=function(){u&&(l.removeAttribute("hidden"),u=!1)}
e.appendChild(l),this.canvas=l,l.mozOpaque=!0
var g=l.getContext("2d",{alpha:!1}),p=o(g)
if(this.outputScale=p,s.PDFJS.useOnlyCssZoom){var v=c.clone({scale:r})
p.sx*=v.width/c.width,p.sy*=v.height/c.height,p.scaled=!0}if(s.PDFJS.maxCanvasPixels>0){var m=c.width*c.height,b=Math.sqrt(s.PDFJS.maxCanvasPixels/m)
p.sx>b||p.sy>b?(p.sx=b,p.sy=b,p.scaled=!0,this.hasRestrictedScaling=!0):this.hasRestrictedScaling=!1}var w=h(p.sx),P=h(p.sy)
l.width=d(c.width*p.sx,w[0]),l.height=d(c.height*p.sy,P[0]),l.style.width=d(c.width,w[1])+"px",l.style.height=d(c.height,P[1])+"px",this.paintedViewportMap.set(l,c)
var y=p.scaled?[p.sx,0,0,p.sy,0,0]:null,S={canvasContext:g,transform:y,viewport:this.viewport,renderInteractiveForms:this.renderInteractiveForms},L=this.pdfPage.render(S)
return L.onContinue=function(e){f(),a.onRenderContinue?a.onRenderContinue(e):e()},L.promise.then(function(){f(),t(void 0)},function(e){f(),i(e)}),a},paintOnSvg:function(e){var t=!1,i=function(){if(t)throw"cancelled"},n=this,a=this.pdfPage,o=s.SVGGraphics,h=this.viewport.clone({scale:r})
return{promise:a.getOperatorList().then(function(t){return i(),new o(a.commonObjs,a.objs).getSVG(t,h).then(function(t){i(),n.svg=t,n.paintedViewportMap.set(t,h),t.style.width=e.style.width,t.style.height=e.style.height,n.renderingState=l.FINISHED,e.appendChild(t)})}),onRenderContinue:function(e){e()},cancel:function(){t=!0}}},setPageLabel:function(e){this.pageLabel="string"==typeof e?e:null,null!==this.pageLabel?this.div.setAttribute("data-page-label",this.pageLabel):this.div.removeAttribute("data-page-label")}},e}()
e.PDFPageView=u}(e.pdfjsWebPDFPageView={},e.pdfjsWebUIUtils,e.pdfjsWebPDFRenderingQueue,e.pdfjsWebDOMEvents,e.pdfjsWebPDFJS)}(this),function(e,t){!function(e,t,i){var n=t.watchScroll,s=t.getVisibleElements,r=t.scrollIntoView,a=i.PDFThumbnailView,o=function(){function e(e){this.container=e.container,this.renderingQueue=e.renderingQueue,this.linkService=e.linkService,this.scroll=n(this.container,this._scrollUpdated.bind(this)),this._resetView()}return e.prototype={_scrollUpdated:function(){this.renderingQueue.renderHighestPriority()},getThumbnail:function(e){return this.thumbnails[e]},_getVisibleThumbs:function(){return s(this.container,this.thumbnails)},scrollThumbnailIntoView:function(e){var t=document.querySelector(".thumbnail.selected")
t&&t.classList.remove("selected")
var i=document.querySelector('div.thumbnail[data-page-number="'+e+'"]')
i&&i.classList.add("selected")
var n=this._getVisibleThumbs(),s=n.views.length
if(s>0){var a=n.first.id,o=s>1?n.last.id:a;(e<=a||e>=o)&&r(i,{top:-19})}},get pagesRotation(){return this._pagesRotation},set pagesRotation(e){this._pagesRotation=e
for(var t=0,i=this.thumbnails.length;t<i;t++){this.thumbnails[t].update(e)}},cleanup:function(){var e=a.tempImageCache
e&&(e.width=0,e.height=0),a.tempImageCache=null},_resetView:function(){this.thumbnails=[],this._pageLabels=null,this._pagesRotation=0,this._pagesRequests=[],this.container.textContent=""},setDocument:function(e){return this.pdfDocument&&(this._cancelRendering(),this._resetView()),this.pdfDocument=e,e?e.getPage(1).then(function(t){for(var i=e.numPages,n=t.getViewport(1),s=1;s<=i;++s){var r=new a({container:this.container,id:s,defaultViewport:n.clone(),linkService:this.linkService,renderingQueue:this.renderingQueue,disableCanvasToImageConversion:!1})
this.thumbnails.push(r)}}.bind(this)):Promise.resolve()},_cancelRendering:function(){for(var e=0,t=this.thumbnails.length;e<t;e++)this.thumbnails[e]&&this.thumbnails[e].cancelRendering()},setPageLabels:function(e){if(this.pdfDocument){e?e instanceof Array&&this.pdfDocument.numPages===e.length?this._pageLabels=e:(this._pageLabels=null,console.error("PDFThumbnailViewer_setPageLabels: Invalid page labels.")):this._pageLabels=null
for(var t=0,i=this.thumbnails.length;t<i;t++){var n=this.thumbnails[t],s=this._pageLabels&&this._pageLabels[t]
n.setPageLabel(s)}}},_ensurePdfPageLoaded:function(e){if(e.pdfPage)return Promise.resolve(e.pdfPage)
var t=e.id
if(this._pagesRequests[t])return this._pagesRequests[t]
var i=this.pdfDocument.getPage(t).then(function(i){return e.setPdfPage(i),this._pagesRequests[t]=null,i}.bind(this))
return this._pagesRequests[t]=i,i},forceRendering:function(){var e=this._getVisibleThumbs(),t=this.renderingQueue.getHighestPriority(e,this.thumbnails,this.scroll.down)
return!!t&&(this._ensurePdfPageLoaded(t).then(function(){this.renderingQueue.renderView(t)}.bind(this)),!0)}},e}()
e.PDFThumbnailViewer=o}(e.pdfjsWebPDFThumbnailViewer={},e.pdfjsWebUIUtils,e.pdfjsWebPDFThumbnailView)}(this),function(e,t){!function(e,t,i){function n(){}var s=function(){function e(e){this.textLayerDiv=e.textLayerDiv,this.eventBus=e.eventBus||t.getGlobalEventBus(),this.textContent=null,this.renderingDone=!1,this.pageIdx=e.pageIndex,this.pageNumber=this.pageIdx+1,this.matches=[],this.viewport=e.viewport,this.textDivs=[],this.findController=e.findController||null,this.textLayerRenderTask=null,this.enhanceTextSelection=e.enhanceTextSelection,this._bindMouse()}return e.prototype={_finishRendering:function(){if(this.renderingDone=!0,!this.enhanceTextSelection){var e=document.createElement("div")
e.className="endOfContent",this.textLayerDiv.appendChild(e)}this.eventBus.dispatch("textlayerrendered",{source:this,pageNumber:this.pageNumber,numTextDivs:this.textDivs.length})},render:function(e){if(this.textContent&&!this.renderingDone){this.cancel(),this.textDivs=[]
var t=document.createDocumentFragment()
this.textLayerRenderTask=i.renderTextLayer({textContent:this.textContent,container:t,viewport:this.viewport,textDivs:this.textDivs,timeout:e,enhanceTextSelection:this.enhanceTextSelection}),this.textLayerRenderTask.promise.then(function(){this.textLayerDiv.appendChild(t),this._finishRendering(),this.updateMatches()}.bind(this),function(e){})}},cancel:function(){this.textLayerRenderTask&&(this.textLayerRenderTask.cancel(),this.textLayerRenderTask=null)},setTextContent:function(e){this.cancel(),this.textContent=e},convertMatches:function(e,t){var i=0,n=0,s=this.textContent.items,r=s.length-1,a=null===this.findController?0:this.findController.state.query.length,o=[]
if(!e)return o
for(var h=0,d=e.length;h<d;h++){for(var c=e[h];i!==r&&c>=n+s[i].str.length;)n+=s[i].str.length,i++
i===s.length&&console.error("Could not find a matching mapping")
var l={begin:{divIdx:i,offset:c-n}}
for(c+=t?t[h]:a;i!==r&&c>n+s[i].str.length;)n+=s[i].str.length,i++
l.end={divIdx:i,offset:c-n},o.push(l)}return o},renderMatches:function(e){function t(e,t){var n=e.divIdx
s[n].textContent="",i(n,0,e.offset,t)}function i(e,t,i,r){var a=s[e],o=n[e].str.substring(t,i),h=document.createTextNode(o)
if(r){var d=document.createElement("span")
return d.className=r,d.appendChild(h),void a.appendChild(d)}a.appendChild(h)}if(0!==e.length){var n=this.textContent.items,s=this.textDivs,r=null,a=this.pageIdx,o=null!==this.findController&&a===this.findController.selected.pageIdx,h=null===this.findController?-1:this.findController.selected.matchIdx,d=null!==this.findController&&this.findController.state.highlightAll,c={divIdx:-1,offset:void 0},l=h,u=l+1
if(d)l=0,u=e.length
else if(!o)return
for(var f=l;f<u;f++){var g=e[f],p=g.begin,v=g.end,m=o&&f===h,b=m?" selected":""
if(this.findController&&this.findController.updateMatchPosition(a,f,s,p.divIdx),r&&p.divIdx===r.divIdx?i(r.divIdx,r.offset,p.offset):(null!==r&&i(r.divIdx,r.offset,c.offset),t(p)),p.divIdx===v.divIdx)i(p.divIdx,p.offset,v.offset,"highlight"+b)
else{i(p.divIdx,p.offset,c.offset,"highlight begin"+b)
for(var w=p.divIdx+1,P=v.divIdx;w<P;w++)s[w].className="highlight middle"+b
t(v,"highlight end"+b)}r=v}r&&i(r.divIdx,r.offset,c.offset)}},updateMatches:function(){if(this.renderingDone){for(var e=this.matches,t=this.textDivs,i=this.textContent.items,n=-1,s=0,r=e.length;s<r;s++){for(var a=e[s],o=Math.max(n,a.begin.divIdx),h=o,d=a.end.divIdx;h<=d;h++){var c=t[h]
c.textContent=i[h].str,c.className=""}n=a.end.divIdx+1}if(null!==this.findController&&this.findController.active){var l,u
null!==this.findController&&(l=this.findController.pageMatches[this.pageIdx]||null,u=this.findController.pageMatchesLength?this.findController.pageMatchesLength[this.pageIdx]||null:null),this.matches=this.convertMatches(l,u),this.renderMatches(this.matches)}}},_bindMouse:function(){var e=this.textLayerDiv,t=this,i=null
e.addEventListener("mousedown",function(n){if(t.enhanceTextSelection&&t.textLayerRenderTask)return t.textLayerRenderTask.expandTextDivs(!0),void(i&&(clearTimeout(i),i=null))
var s=e.querySelector(".endOfContent")
if(s){var r=n.target!==e
if(r=r&&"none"!==window.getComputedStyle(s).getPropertyValue("-moz-user-select")){var a=e.getBoundingClientRect(),o=Math.max(0,(n.pageY-a.top)/a.height)
s.style.top=(100*o).toFixed(2)+"%"}s.classList.add("active")}}),e.addEventListener("mouseup",function(n){if(t.enhanceTextSelection&&t.textLayerRenderTask)return void(i=setTimeout(function(){t.textLayerRenderTask&&t.textLayerRenderTask.expandTextDivs(!1),i=null},300))
var s=e.querySelector(".endOfContent")
s&&(s.style.top="",s.classList.remove("active"))})}},e}()
n.prototype={createTextLayerBuilder:function(e,t,i,n){return new s({textLayerDiv:e,pageIndex:t,viewport:i,enhanceTextSelection:n})}},e.TextLayerBuilder=s,e.DefaultTextLayerFactory=n}(e.pdfjsWebTextLayerBuilder={},e.pdfjsWebDOMEvents,e.pdfjsWebPDFJS)}(this),function(e,t){!function(e,t,i,n){function s(){}var r=t.mozL10n,a=i.SimpleLinkService,o=function(){function e(e){this.pageDiv=e.pageDiv,this.pdfPage=e.pdfPage,this.renderInteractiveForms=e.renderInteractiveForms,this.linkService=e.linkService,this.downloadManager=e.downloadManager,this.div=null}return e.prototype={render:function(e,t){var i=this,s={intent:void 0===t?"display":t}
this.pdfPage.getAnnotations(s).then(function(t){if(e=e.clone({dontFlip:!0}),s={viewport:e,div:i.div,annotations:t,page:i.pdfPage,renderInteractiveForms:i.renderInteractiveForms,linkService:i.linkService,downloadManager:i.downloadManager},i.div)n.AnnotationLayer.update(s)
else{if(0===t.length)return
i.div=document.createElement("div"),i.div.className="annotationLayer",i.pageDiv.appendChild(i.div),s.div=i.div,n.AnnotationLayer.render(s),void 0!==r&&r.translate(i.div)}})},hide:function(){this.div&&this.div.setAttribute("hidden","true")}},e}()
s.prototype={createAnnotationLayerBuilder:function(e,t,i){return new o({pageDiv:e,pdfPage:t,renderInteractiveForms:i,linkService:new a})}},e.AnnotationLayerBuilder=o,e.DefaultAnnotationLayerFactory=s}(e.pdfjsWebAnnotationLayerBuilder={},e.pdfjsWebUIUtils,e.pdfjsWebPDFLinkService,e.pdfjsWebPDFJS)}(this),function(e,t){!function(e,t,i,n,s,r,a,o,h){var d=t.UNKNOWN_SCALE,c=t.SCROLLBAR_PADDING,l=t.VERTICAL_PADDING,u=t.MAX_AUTO_SCALE,f=t.CSS_UNITS,g=t.DEFAULT_SCALE,p=t.DEFAULT_SCALE_VALUE,v=t.RendererType,m=t.scrollIntoView,b=t.watchScroll,w=t.getVisibleElements,P=i.PDFPageView,y=n.RenderingStates,S=n.PDFRenderingQueue,L=s.TextLayerBuilder,C=r.AnnotationLayerBuilder,I=a.SimpleLinkService,_={UNKNOWN:0,NORMAL:1,CHANGING:2,FULLSCREEN:3},B=function(){function e(e){var t=[]
this.push=function(i){var n=t.indexOf(i)
n>=0&&t.splice(n,1),t.push(i),t.length>e&&t.shift().destroy()},this.resize=function(i){for(e=i;t.length>e;)t.shift().destroy()}}function t(e,t){return t===e||Math.abs(t-e)<1e-15}function i(e){this.container=e.container,this.viewer=e.viewer||e.container.firstElementChild,this.eventBus=e.eventBus||o.getGlobalEventBus(),this.linkService=e.linkService||new I,this.downloadManager=e.downloadManager||null,this.removePageBorders=e.removePageBorders||!1,this.enhanceTextSelection=e.enhanceTextSelection||!1,this.renderInteractiveForms=e.renderInteractiveForms||!1,this.renderer=e.renderer||v.CANVAS,this.defaultRenderingQueue=!e.renderingQueue,this.defaultRenderingQueue?(this.renderingQueue=new S,this.renderingQueue.setViewer(this)):this.renderingQueue=e.renderingQueue,this.scroll=b(this.container,this._scrollUpdate.bind(this)),this.presentationModeState=_.UNKNOWN,this._resetView(),this.removePageBorders&&this.viewer.classList.add("removePageBorders")}return i.prototype={get pagesCount(){return this._pages.length},getPageView:function(e){return this._pages[e]},get pageViewsReady(){return this._pageViewsReady},get currentPageNumber(){return this._currentPageNumber},set currentPageNumber(e){if((0|e)!==e)throw new Error("Invalid page number.")
if(!this.pdfDocument)return void(this._currentPageNumber=e)
this._setCurrentPageNumber(e,!0)},_setCurrentPageNumber:function(e,t){if(this._currentPageNumber===e)return void(t&&this._resetCurrentPageView())
if(!(0<e&&e<=this.pagesCount))return void console.error('PDFViewer_setCurrentPageNumber: "'+e+'" is out of bounds.')
var i={source:this,pageNumber:e,pageLabel:this._pageLabels&&this._pageLabels[e-1]}
this._currentPageNumber=e,this.eventBus.dispatch("pagechanging",i),this.eventBus.dispatch("pagechange",i),t&&this._resetCurrentPageView()},get currentPageLabel(){return this._pageLabels&&this._pageLabels[this._currentPageNumber-1]},set currentPageLabel(e){var t=0|e
if(this._pageLabels){var i=this._pageLabels.indexOf(e)
i>=0&&(t=i+1)}this.currentPageNumber=t},get currentScale(){return this._currentScale!==d?this._currentScale:g},set currentScale(e){if(isNaN(e))throw new Error("Invalid numeric scale")
if(!this.pdfDocument)return this._currentScale=e,void(this._currentScaleValue=e!==d?e.toString():null)
this._setScale(e,!1)},get currentScaleValue(){return this._currentScaleValue},set currentScaleValue(e){if(!this.pdfDocument)return this._currentScale=isNaN(e)?d:e,void(this._currentScaleValue=e.toString())
this._setScale(e,!1)},get pagesRotation(){return this._pagesRotation},set pagesRotation(e){if("number"!=typeof e||e%90!=0)throw new Error("Invalid pages rotation angle.")
if(this._pagesRotation=e,this.pdfDocument){for(var t=0,i=this._pages.length;t<i;t++){var n=this._pages[t]
n.update(n.scale,e)}this._setScale(this._currentScaleValue,!0),this.defaultRenderingQueue&&this.update()}},setDocument:function(e){if(this.pdfDocument&&(this._cancelRendering(),this._resetView()),this.pdfDocument=e,e){var t,i=e.numPages,n=this,s=new Promise(function(e){t=e})
this.pagesPromise=s,s.then(function(){n._pageViewsReady=!0,n.eventBus.dispatch("pagesloaded",{source:n,pagesCount:i})})
var r=!1,a=null,o=new Promise(function(e){a=e})
this.onePageRendered=o
var d=function(e){e.onBeforeDraw=function(){n._buffer.push(this)},e.onAfterDraw=function(){r||(r=!0,a())}},c=e.getPage(1)
return this.firstPagePromise=c,c.then(function(s){for(var r=this.currentScale,a=s.getViewport(r*f),c=1;c<=i;++c){var l=null
h.PDFJS.disableTextLayer||(l=this)
var u=new P({container:this.viewer,eventBus:this.eventBus,id:c,scale:r,defaultViewport:a.clone(),renderingQueue:this.renderingQueue,textLayerFactory:l,annotationLayerFactory:this,enhanceTextSelection:this.enhanceTextSelection,renderInteractiveForms:this.renderInteractiveForms,renderer:this.renderer})
d(u),this._pages.push(u)}var g=this.linkService
o.then(function(){if(h.PDFJS.disableAutoFetch)t()
else for(var s=i,r=1;r<=i;++r)e.getPage(r).then(function(e,i){var r=n._pages[e-1]
r.pdfPage||r.setPdfPage(i),g.cachePageRef(e,i.ref),--s||t()}.bind(null,r))}),n.eventBus.dispatch("pagesinit",{source:n}),this.defaultRenderingQueue&&this.update(),this.findController&&this.findController.resolveFirstPage()}.bind(this))}},setPageLabels:function(e){if(this.pdfDocument){e?e instanceof Array&&this.pdfDocument.numPages===e.length?this._pageLabels=e:(this._pageLabels=null,console.error("PDFViewer_setPageLabels: Invalid page labels.")):this._pageLabels=null
for(var t=0,i=this._pages.length;t<i;t++){var n=this._pages[t],s=this._pageLabels&&this._pageLabels[t]
n.setPageLabel(s)}}},_resetView:function(){this._pages=[],this._currentPageNumber=1,this._currentScale=d,this._currentScaleValue=null,this._pageLabels=null,this._buffer=new e(10),this._location=null,this._pagesRotation=0,this._pagesRequests=[],this._pageViewsReady=!1,this.viewer.textContent=""},_scrollUpdate:function(){if(0!==this.pagesCount){this.update()
for(var e=0,t=this._pages.length;e<t;e++)this._pages[e].updatePosition()}},_setScaleDispatchEvent:function(e,t,i){var n={source:this,scale:e,presetValue:i?t:void 0}
this.eventBus.dispatch("scalechanging",n),this.eventBus.dispatch("scalechange",n)},_setScaleUpdatePages:function(e,i,n,s){if(this._currentScaleValue=i.toString(),t(this._currentScale,e))return void(s&&this._setScaleDispatchEvent(e,i,!0))
for(var r=0,a=this._pages.length;r<a;r++)this._pages[r].update(e)
if(this._currentScale=e,!n){var o,d=this._currentPageNumber
!this._location||h.PDFJS.ignoreCurrentPositionOnZoom||this.isInPresentationMode||this.isChangingPresentationMode||(d=this._location.pageNumber,o=[null,{name:"XYZ"},this._location.left,this._location.top,null]),this.scrollPageIntoView({pageNumber:d,destArray:o,allowNegativeOffset:!0})}this._setScaleDispatchEvent(e,i,s),this.defaultRenderingQueue&&this.update()},_setScale:function(e,t){var i=parseFloat(e)
if(i>0)this._setScaleUpdatePages(i,e,t,!1)
else{var n=this._pages[this._currentPageNumber-1]
if(!n)return
var s=this.isInPresentationMode||this.removePageBorders?0:c,r=this.isInPresentationMode||this.removePageBorders?0:l,a=(this.container.clientWidth-s)/n.width*n.scale,o=(this.container.clientHeight-r)/n.height*n.scale
switch(e){case"page-actual":i=1
break
case"page-width":i=a
break
case"page-height":i=o
break
case"page-fit":i=Math.min(a,o)
break
case"auto":var h=n.width>n.height,d=h?Math.min(o,a):a
i=Math.min(u,d)
break
default:return void console.error('PDFViewer_setScale: "'+e+'" is an unknown zoom value.')}this._setScaleUpdatePages(i,e,t,!0)}},_resetCurrentPageView:function(){this.isInPresentationMode&&this._setScale(this._currentScaleValue,!0)
var e=this._pages[this._currentPageNumber-1]
m(e.div)},scrollPageIntoView:function(e){if(this.pdfDocument){if(arguments.length>1||"number"==typeof e){console.warn("Call of scrollPageIntoView() with obsolete signature.")
var t={}
"number"==typeof e&&(t.pageNumber=e),arguments[1]instanceof Array&&(t.destArray=arguments[1]),e=t}var i=e.pageNumber||0,n=e.destArray||null,s=e.allowNegativeOffset||!1
if(this.isInPresentationMode||!n)return void this._setCurrentPageNumber(i,!0)
var r=this._pages[i-1]
if(!r)return void console.error('PDFViewer_scrollPageIntoView: Invalid "pageNumber" parameter.')
var a,o,h=0,u=0,g=0,v=0,b=r.rotation%180!=0,w=(b?r.height:r.width)/r.scale/f,P=(b?r.width:r.height)/r.scale/f,y=0
switch(n[1].name){case"XYZ":h=n[2],u=n[3],y=n[4],h=null!==h?h:0,u=null!==u?u:P
break
case"Fit":case"FitB":y="page-fit"
break
case"FitH":case"FitBH":u=n[2],y="page-width",null===u&&this._location&&(h=this._location.left,u=this._location.top)
break
case"FitV":case"FitBV":h=n[2],g=w,v=P,y="page-height"
break
case"FitR":h=n[2],u=n[3],g=n[4]-h,v=n[5]-u
var S=this.removePageBorders?0:c,L=this.removePageBorders?0:l
a=(this.container.clientWidth-S)/g/f,o=(this.container.clientHeight-L)/v/f,y=Math.min(Math.abs(a),Math.abs(o))
break
default:return void console.error("PDFViewer_scrollPageIntoView: '"+n[1].name+"' is not a valid destination type.")}if(y&&y!==this._currentScale?this.currentScaleValue=y:this._currentScale===d&&(this.currentScaleValue=p),"page-fit"===y&&!n[4])return void m(r.div)
var C=[r.viewport.convertToViewportPoint(h,u),r.viewport.convertToViewportPoint(h+g,u+v)],I=Math.min(C[0][0],C[1][0]),_=Math.min(C[0][1],C[1][1])
s||(I=Math.max(I,0),_=Math.max(_,0)),m(r.div,{left:I,top:_})}},_updateLocation:function(e){var t=this._currentScale,i=this._currentScaleValue,n=parseFloat(i)===t?Math.round(1e4*t)/100:i,s=e.id,r="#page="+s
r+="&zoom="+n
var a=this._pages[s-1],o=this.container,h=a.getPagePoint(o.scrollLeft-e.x,o.scrollTop-e.y),d=Math.round(h[0]),c=Math.round(h[1])
r+=","+d+","+c,this._location={pageNumber:s,scale:n,top:c,left:d,pdfOpenParams:r}},update:function(){var e=this._getVisiblePages(),t=e.views
if(0!==t.length){var i=Math.max(10,2*t.length+1)
this._buffer.resize(i),this.renderingQueue.renderHighestPriority(e)
for(var n=this._currentPageNumber,s=e.first,r=0,a=t.length,o=!1;r<a;++r){var h=t[r]
if(h.percent<100)break
if(h.id===n){o=!0
break}}o||(n=t[0].id),this.isInPresentationMode||this._setCurrentPageNumber(n),this._updateLocation(s),this.eventBus.dispatch("updateviewarea",{source:this,location:this._location})}},containsElement:function(e){return this.container.contains(e)},focus:function(){this.container.focus()},get isInPresentationMode(){return this.presentationModeState===_.FULLSCREEN},get isChangingPresentationMode(){return this.presentationModeState===_.CHANGING},get isHorizontalScrollbarEnabled(){return!this.isInPresentationMode&&this.container.scrollWidth>this.container.clientWidth},_getVisiblePages:function(){if(!this.isInPresentationMode)return w(this.container,this._pages,!0)
var e=[],t=this._pages[this._currentPageNumber-1]
return e.push({id:t.id,view:t}),{first:t,last:t,views:e}},cleanup:function(){for(var e=0,t=this._pages.length;e<t;e++)this._pages[e]&&this._pages[e].renderingState!==y.FINISHED&&this._pages[e].reset()},_cancelRendering:function(){for(var e=0,t=this._pages.length;e<t;e++)this._pages[e]&&this._pages[e].cancelRendering()},_ensurePdfPageLoaded:function(e){if(e.pdfPage)return Promise.resolve(e.pdfPage)
var t=e.id
if(this._pagesRequests[t])return this._pagesRequests[t]
var i=this.pdfDocument.getPage(t).then(function(i){return e.setPdfPage(i),this._pagesRequests[t]=null,i}.bind(this))
return this._pagesRequests[t]=i,i},forceRendering:function(e){var t=e||this._getVisiblePages(),i=this.renderingQueue.getHighestPriority(t,this._pages,this.scroll.down)
return!!i&&(this._ensurePdfPageLoaded(i).then(function(){this.renderingQueue.renderView(i)}.bind(this)),!0)},getPageTextContent:function(e){return this.pdfDocument.getPage(e+1).then(function(e){return e.getTextContent({normalizeWhitespace:!0})})},createTextLayerBuilder:function(e,t,i,n){return new L({textLayerDiv:e,eventBus:this.eventBus,pageIndex:t,viewport:i,findController:this.isInPresentationMode?null:this.findController,enhanceTextSelection:!this.isInPresentationMode&&n})},createAnnotationLayerBuilder:function(e,t,i){return new C({pageDiv:e,pdfPage:t,renderInteractiveForms:i,linkService:this.linkService,downloadManager:this.downloadManager})},setFindController:function(e){this.findController=e},getPagesOverview:function(){return this._pages.map(function(e){var t=e.pdfPage.getViewport(1)
return{width:t.width,height:t.height}})}},i}()
e.PresentationModeState=_,e.PDFViewer=B}(e.pdfjsWebPDFViewer={},e.pdfjsWebUIUtils,e.pdfjsWebPDFPageView,e.pdfjsWebPDFRenderingQueue,e.pdfjsWebTextLayerBuilder,e.pdfjsWebAnnotationLayerBuilder,e.pdfjsWebPDFLinkService,e.pdfjsWebDOMEvents,e.pdfjsWebPDFJS)}(this),function(e,t){!function(e,t,i,n,s,r,a,o,h,d,c,l,u,f,g,p,v,m,b,w,P,y,S,L){function C(e){e.imageResourcesPath="./images/",e.workerSrc="../build/pdf.worker.js",e.cMapUrl="../web/cmaps/",e.cMapPacked=!0}function I(e){return new Promise(function(t,i){var n=He.appConfig,s=document.createElement("script")
s.src=n.debuggerScriptPath,s.onload=function(){PDFBug.enable(e),PDFBug.init(L,n.mainContainer),t()},s.onerror=function(){i(new Error("Cannot load debugger at "+s.src))},(document.getElementsByTagName("head")[0]||document.body).appendChild(s)})}function _(){var e,t=document.location.search.substring(1),i=fe(t)
e="file"in i?i.file:DEFAULT_URL,se(e)
var n=[],s=He.appConfig,r=document.createElement("input")
r.id=s.openFileInputName,r.className="fileInput",r.setAttribute("type","file"),r.oncontextmenu=le,document.body.appendChild(r),window.File&&window.FileReader&&window.FileList&&window.Blob?r.value=null:(s.toolbar.openFile.setAttribute("hidden","true"),s.secondaryToolbar.openFileButton.setAttribute("hidden","true"))
var a=L.PDFJS
if(He.viewerPrefs.pdfBugEnabled){var o=document.location.hash.substring(1),h=fe(o)
if("disableworker"in h&&(a.disableWorker="true"===h.disableworker),"disablerange"in h&&(a.disableRange="true"===h.disablerange),"disablestream"in h&&(a.disableStream="true"===h.disablestream),"disableautofetch"in h&&(a.disableAutoFetch="true"===h.disableautofetch),"disablefontface"in h&&(a.disableFontFace="true"===h.disablefontface),"disablehistory"in h&&(a.disableHistory="true"===h.disablehistory),"webgl"in h&&(a.disableWebGL="true"!==h.webgl),"useonlycsszoom"in h&&(a.useOnlyCssZoom="true"===h.useonlycsszoom),"verbosity"in h&&(a.verbosity=0|h.verbosity),"ignorecurrentpositiononzoom"in h&&(a.ignoreCurrentPositionOnZoom="true"===h.ignorecurrentpositiononzoom),"locale"in h&&(a.locale=h.locale),"textlayer"in h)switch(h.textlayer){case"off":a.disableTextLayer=!0
break
case"visible":case"shadow":case"hover":s.viewerContainer.classList.add("textLayer-"+h.textlayer)}if("pdfbug"in h){a.pdfBug=!0
var d=h.pdfbug,c=d.split(",")
n.push(I(c))}}ue.setLanguage(a.locale),He.supportsPrinting||(s.toolbar.print.classList.add("hidden"),s.secondaryToolbar.printButton.classList.add("hidden")),He.supportsFullscreen||(s.toolbar.presentationModeButton.classList.add("hidden"),s.secondaryToolbar.presentationModeButton.classList.add("hidden")),He.supportsIntegratedFind&&s.toolbar.viewFind.classList.add("hidden"),s.sidebar.mainContainer.addEventListener("transitionend",function(e){e.target===this&&He.eventBus.dispatch("resize")},!0),s.sidebar.toggleButton.addEventListener("click",function(){He.pdfSidebar.toggle()}),Promise.all(n).then(function(){ze(e)}).catch(function(e){He.error(ue.get("loading_error",null,"An error occurred while opening."),e)})}function B(e){var t=e.pageNumber,i=t-1,n=He.pdfViewer.getPageView(i)
if(t===He.page&&He.toolbar.updateLoadingIndicatorState(!1),n){if(He.pdfSidebar.isThumbnailViewVisible){He.pdfThumbnailViewer.getThumbnail(i).setImage(n)}L.PDFJS.pdfBug&&Stats.enabled&&n.stats&&Stats.add(t,n.stats),n.error&&He.error(ue.get("rendering_error",null,"An error occurred while rendering the page."),n.error)}}function E(e){}function T(e){var t,i=e.mode
switch(i){case"thumbs":t=ve.THUMBS
break
case"bookmarks":case"outline":t=ve.OUTLINE
break
case"attachments":t=ve.ATTACHMENTS
break
case"none":t=ve.NONE
break
default:return void console.error('Invalid "pagemode" hash parameter: '+i)}He.pdfSidebar.switchView(t,!0)}function F(e){switch(e.action){case"GoToPage":He.appConfig.toolbar.pageNumber.select()
break
case"Find":He.supportsIntegratedFind||He.findBar.toggle()}}function x(e){var t=e.active,i=e.switchInProgress
He.pdfViewer.presentationModeState=i?_e.CHANGING:t?_e.FULLSCREEN:_e.NORMAL}function D(e){He.pdfRenderingQueue.isThumbnailViewEnabled=He.pdfSidebar.isThumbnailViewVisible
var t=He.store
t&&He.isInitialViewSet&&t.initializedPromise.then(function(){t.set("sidebarView",e.view).catch(function(){})})}function k(e){var t=e.location,i=He.store
i&&i.initializedPromise.then(function(){i.setMultiple({exists:!0,page:t.pageNumber,zoom:t.scale,scrollLeft:t.left,scrollTop:t.top}).catch(function(){})})
var n=He.pdfLinkService.getAnchorUrl(t.pdfOpenParams)
He.appConfig.toolbar.viewBookmark.href=n,He.appConfig.secondaryToolbar.viewBookmarkButton.href=n,He.pdfHistory.updateCurrentBookmark(t.pdfOpenParams,t.pageNumber)
var s=He.pdfViewer.getPageView(He.page-1),r=s.renderingState!==Ee.FINISHED
He.toolbar.updateLoadingIndicatorState(r)}function V(){var e=He.pdfViewer.currentScaleValue
"auto"===e||"page-fit"===e||"page-width"===e?He.pdfViewer.currentScaleValue=e:e||(He.pdfViewer.currentScaleValue=ae),He.pdfViewer.update()}function N(e){if(He.pdfHistory.isHashChangeUnlocked){var t=e.hash
if(!t)return
He.isInitialViewSet?He.pdfLinkService.setHash(t):He.initialBookmark=t}}function M(){He.requestPresentationMode()}function O(){var e=He.appConfig.openFileInputName
document.getElementById(e).click()}function R(){window.print()}function A(){He.download()}function j(){He.pdfDocument&&(He.page=1)}function U(){He.pdfDocument&&(He.page=He.pagesCount)}function H(){He.page++}function W(){He.page--}function z(){He.zoomIn()}function q(){He.zoomOut()}function G(e){var t=He.pdfViewer
t.currentPageLabel=e.value,e.value!==t.currentPageNumber.toString()&&e.value!==t.currentPageLabel&&He.toolbar.setPageNumber(t.currentPageNumber,t.currentPageLabel)}function Q(e){He.pdfViewer.currentScaleValue=e.value}function J(){He.rotatePages(90)}function K(){He.rotatePages(-90)}function X(){He.pdfDocumentProperties.open()}function Z(e){He.findController.executeCommand("find"+e.type,{query:e.query,phraseSearch:e.phraseSearch,caseSensitive:e.caseSensitive,highlightAll:e.highlightAll,findPrevious:e.findPrevious})}function Y(e){He.findController.executeCommand("find",{query:e.query,phraseSearch:e.phraseSearch,caseSensitive:!1,highlightAll:!0,findPrevious:!1})}function $(e){He.toolbar.setPageScale(e.presetValue,e.scale),He.pdfViewer.update()}function ee(e){var t=e.pageNumber
if(He.toolbar.setPageNumber(t,e.pageLabel||null),He.secondaryToolbar.setPageNumber(t),He.pdfSidebar.isThumbnailViewVisible&&He.pdfThumbnailViewer.scrollThumbnailIntoView(t),L.PDFJS.pdfBug&&Stats.enabled){var i=He.pdfViewer.getPageView(t-1)
i.stats&&Stats.add(t,i.stats)}}function te(e){var t=He.pdfViewer
if(!t.isInPresentationMode)if(e.ctrlKey||e.metaKey){var i=He.supportedMouseWheelZoomModifierKeys
if(e.ctrlKey&&!i.ctrlKey||e.metaKey&&!i.metaKey)return
if(e.preventDefault(),Qe)return
var n=t.currentScale,s=Oe(e),r=3*s
r<0?He.zoomOut(-r):He.zoomIn(r)
var a=t.currentScale
if(n!==a){var o=a/n-1,h=t.container.getBoundingClientRect(),d=e.clientX-h.left,c=e.clientY-h.top
t.container.scrollLeft+=d*o,t.container.scrollTop+=c*o}}else Qe=!0,clearTimeout(Ge),Ge=setTimeout(function(){Qe=!1},1e3)}function ie(e){if(He.secondaryToolbar.isOpen){var t=He.appConfig;(He.pdfViewer.containsElement(e.target)||t.toolbar.container.contains(e.target)&&e.target!==t.secondaryToolbar.toggleButton)&&He.secondaryToolbar.close()}}function ne(e){if(!De.active){var t=!1,i=!1,n=(e.ctrlKey?1:0)|(e.altKey?2:0)|(e.shiftKey?4:0)|(e.metaKey?8:0),s=He.pdfViewer,r=s&&s.isInPresentationMode
if(1===n||8===n||5===n||12===n)switch(e.keyCode){case 70:He.supportsIntegratedFind||(He.findBar.open(),t=!0)
break
case 71:if(!He.supportsIntegratedFind){var a=He.findController.state
a&&He.findController.executeCommand("findagain",{query:a.query,phraseSearch:a.phraseSearch,caseSensitive:a.caseSensitive,highlightAll:a.highlightAll,findPrevious:5===n||12===n}),t=!0}break
case 61:case 107:case 187:case 171:r||He.zoomIn(),t=!0
break
case 173:case 109:case 189:r||He.zoomOut(),t=!0
break
case 48:case 96:r||(setTimeout(function(){s.currentScaleValue=ae}),t=!1)
break
case 38:(r||He.page>1)&&(He.page=1,t=!0,i=!0)
break
case 40:(r||He.page<He.pagesCount)&&(He.page=He.pagesCount,t=!0,i=!0)}if(1===n||8===n)switch(e.keyCode){case 83:He.download(),t=!0}if(3===n||10===n)switch(e.keyCode){case 80:He.requestPresentationMode(),t=!0
break
case 71:He.appConfig.toolbar.pageNumber.select(),t=!0}if(t)return i&&!r&&s.focus(),void e.preventDefault()
var o=document.activeElement||document.querySelector(":focus"),h=o&&o.tagName.toUpperCase()
if("INPUT"!==h&&"TEXTAREA"!==h&&"SELECT"!==h||27===e.keyCode){if(0===n)switch(e.keyCode){case 38:case 33:case 8:if(!r&&"page-fit"!==s.currentScaleValue)break
case 37:if(s.isHorizontalScrollbarEnabled)break
case 75:case 80:He.page>1&&He.page--,t=!0
break
case 27:He.secondaryToolbar.isOpen&&(He.secondaryToolbar.close(),t=!0),!He.supportsIntegratedFind&&He.findBar.opened&&(He.findBar.close(),t=!0)
break
case 40:case 34:case 32:if(!r&&"page-fit"!==s.currentScaleValue)break
case 39:if(s.isHorizontalScrollbarEnabled)break
case 74:case 78:He.page<He.pagesCount&&He.page++,t=!0
break
case 36:(r||He.page>1)&&(He.page=1,t=!0,i=!0)
break
case 35:(r||He.page<He.pagesCount)&&(He.page=He.pagesCount,t=!0,i=!0)
break
case 72:r||He.handTool.toggle()
break
case 82:He.rotatePages(90)}if(4===n)switch(e.keyCode){case 32:if(!r&&"page-fit"!==s.currentScaleValue)break
He.page>1&&He.page--,t=!0
break
case 82:He.rotatePages(-90)}if(t||r||(e.keyCode>=33&&e.keyCode<=40||32===e.keyCode&&"BUTTON"!==h)&&(i=!0),2===n)switch(e.keyCode){case 37:r&&(He.pdfHistory.back(),t=!0)
break
case 39:r&&(He.pdfHistory.forward(),t=!0)}i&&!s.containsElement(o)&&s.focus(),t&&e.preventDefault()}}}var se,re=t.UNKNOWN_SCALE,ae=t.DEFAULT_SCALE_VALUE,oe=t.MIN_SCALE,he=t.MAX_SCALE,de=t.ProgressBar,ce=t.getPDFFileNameFromURL,le=t.noContextMenuHandler,ue=t.mozL10n,fe=t.parseQueryString,ge=n.PDFHistory,pe=s.Preferences,ve=r.SidebarView,me=r.PDFSidebar,be=a.ViewHistory,we=o.PDFThumbnailViewer,Pe=h.Toolbar,ye=d.SecondaryToolbar,Se=c.PasswordPrompt,Le=l.PDFPresentationMode,Ce=u.PDFDocumentProperties,Ie=f.HandTool,_e=g.PresentationModeState,Be=g.PDFViewer,Ee=p.RenderingStates,Te=p.PDFRenderingQueue,Fe=v.PDFLinkService,xe=m.PDFOutlineViewer,De=b.OverlayManager,ke=w.PDFAttachmentViewer,Ve=P.PDFFindController,Ne=y.PDFFindBar,Me=S.getGlobalEventBus,Oe=t.normalizeWheelEventDelta,Re=t.animationStarted,Ae=t.localized,je=t.RendererType,Ue={updateFindControlState:function(e){},initPassiveLoading:function(e){},fallback:function(e,t){},reportTelemetry:function(e){},createDownloadManager:function(){return new i.DownloadManager},supportsIntegratedFind:!1,supportsDocumentFonts:!0,supportsDocumentColors:!0,supportedMouseWheelZoomModifierKeys:{ctrlKey:!0,metaKey:!0}},He={initialBookmark:document.location.hash.substring(1),initialDestination:null,initialized:!1,fellback:!1,appConfig:null,pdfDocument:null,pdfLoadingTask:null,printService:null,pdfViewer:null,pdfThumbnailViewer:null,pdfRenderingQueue:null,pdfPresentationMode:null,pdfDocumentProperties:null,pdfLinkService:null,pdfHistory:null,pdfSidebar:null,pdfOutlineViewer:null,pdfAttachmentViewer:null,store:null,downloadManager:null,toolbar:null,secondaryToolbar:null,eventBus:null,pageRotation:0,isInitialViewSet:!1,viewerPrefs:{sidebarViewOnLoad:ve.NONE,pdfBugEnabled:!1,showPreviousViewOnLoad:!0,defaultZoomValue:"",disablePageLabels:!1,renderer:"canvas",enhanceTextSelection:!1,renderInteractiveForms:!1},isViewerEmbedded:window.parent!==window,url:"",baseUrl:"",externalServices:Ue,initialize:function(e){var t=this,i=L.PDFJS
return pe.initialize(),this.preferences=pe,C(i),this.appConfig=e,this._readPreferences().then(function(){return t._initializeViewerComponents()}).then(function(){t.bindEvents(),t.bindWindowEvents(),Ae.then(function(){t.eventBus.dispatch("localized")}),t.isViewerEmbedded&&!i.isExternalLinkTargetSet()&&(i.externalLinkTarget=i.LinkTarget.TOP),t.initialized=!0})},_readPreferences:function(){var e=this,t=L.PDFJS
return Promise.all([pe.get("enableWebGL").then(function(e){t.disableWebGL=!e}),pe.get("sidebarViewOnLoad").then(function(t){e.viewerPrefs.sidebarViewOnLoad=t}),pe.get("pdfBugEnabled").then(function(t){e.viewerPrefs.pdfBugEnabled=t}),pe.get("showPreviousViewOnLoad").then(function(t){e.viewerPrefs.showPreviousViewOnLoad=t}),pe.get("defaultZoomValue").then(function(t){e.viewerPrefs.defaultZoomValue=t}),pe.get("enhanceTextSelection").then(function(t){e.viewerPrefs.enhanceTextSelection=t}),pe.get("disableTextLayer").then(function(e){!0!==t.disableTextLayer&&(t.disableTextLayer=e)}),pe.get("disableRange").then(function(e){!0!==t.disableRange&&(t.disableRange=e)}),pe.get("disableStream").then(function(e){!0!==t.disableStream&&(t.disableStream=e)}),pe.get("disableAutoFetch").then(function(e){t.disableAutoFetch=e}),pe.get("disableFontFace").then(function(e){!0!==t.disableFontFace&&(t.disableFontFace=e)}),pe.get("useOnlyCssZoom").then(function(e){t.useOnlyCssZoom=e}),pe.get("externalLinkTarget").then(function(e){t.isExternalLinkTargetSet()||(t.externalLinkTarget=e)}),pe.get("renderer").then(function(t){e.viewerPrefs.renderer=t}),pe.get("renderInteractiveForms").then(function(t){e.viewerPrefs.renderInteractiveForms=t}),pe.get("disablePageLabels").then(function(t){e.viewerPrefs.disablePageLabels=t})]).catch(function(e){})},_initializeViewerComponents:function(){var e=this,t=this.appConfig
return new Promise(function(i,n){var s=t.eventBus||Me()
e.eventBus=s
var r=new Te
r.onIdle=e.cleanup.bind(e),e.pdfRenderingQueue=r
var a=new Fe({eventBus:s})
e.pdfLinkService=a
var o=e.externalServices.createDownloadManager()
e.downloadManager=o
var h=t.mainContainer,d=t.viewerContainer
e.pdfViewer=new Be({container:h,viewer:d,eventBus:s,renderingQueue:r,linkService:a,downloadManager:o,renderer:e.viewerPrefs.renderer,enhanceTextSelection:e.viewerPrefs.enhanceTextSelection,renderInteractiveForms:e.viewerPrefs.renderInteractiveForms}),r.setViewer(e.pdfViewer),a.setViewer(e.pdfViewer)
var c=t.sidebar.thumbnailView
e.pdfThumbnailViewer=new we({container:c,renderingQueue:r,linkService:a}),r.setThumbnailViewer(e.pdfThumbnailViewer),e.pdfHistory=new ge({linkService:a,eventBus:s}),a.setHistory(e.pdfHistory),e.findController=new Ve({pdfViewer:e.pdfViewer}),e.findController.onUpdateResultsCount=function(t){e.supportsIntegratedFind||e.findBar.updateResultsCount(t)},e.findController.onUpdateState=function(t,i,n){e.supportsIntegratedFind?e.externalServices.updateFindControlState({result:t,findPrevious:i}):e.findBar.updateUIState(t,i,n)},e.pdfViewer.setFindController(e.findController)
var l=Object.create(t.findBar)
l.findController=e.findController,l.eventBus=s,e.findBar=new Ne(l),e.overlayManager=De,e.handTool=new Ie({container:h,eventBus:s}),e.pdfDocumentProperties=new Ce(t.documentProperties),e.toolbar=new Pe(t.toolbar,h,s),e.secondaryToolbar=new ye(t.secondaryToolbar,h,s),e.supportsFullscreen&&(e.pdfPresentationMode=new Le({container:h,viewer:d,pdfViewer:e.pdfViewer,eventBus:s,contextMenuItems:t.fullscreen})),e.passwordPrompt=new Se(t.passwordOverlay),e.pdfOutlineViewer=new xe({container:t.sidebar.outlineView,eventBus:s,linkService:a}),e.pdfAttachmentViewer=new ke({container:t.sidebar.attachmentsView,eventBus:s,downloadManager:o})
var u=Object.create(t.sidebar)
u.pdfViewer=e.pdfViewer,u.pdfThumbnailViewer=e.pdfThumbnailViewer,u.pdfOutlineViewer=e.pdfOutlineViewer,u.eventBus=s,e.pdfSidebar=new me(u),e.pdfSidebar.onToggled=e.forceRendering.bind(e),i(void 0)})},run:function(e){this.initialize(e).then(_)},zoomIn:function(e){var t=this.pdfViewer.currentScale
do{t=(1.1*t).toFixed(2),t=Math.ceil(10*t)/10,t=Math.min(he,t)}while(--e>0&&t<he)
this.pdfViewer.currentScaleValue=t},zoomOut:function(e){var t=this.pdfViewer.currentScale
do{t=(t/1.1).toFixed(2),t=Math.floor(10*t)/10,t=Math.max(oe,t)}while(--e>0&&t>oe)
this.pdfViewer.currentScaleValue=t},get pagesCount(){return this.pdfDocument?this.pdfDocument.numPages:0},set page(e){this.pdfViewer.currentPageNumber=e},get page(){return this.pdfViewer.currentPageNumber},get printing(){return!!this.printService},get supportsPrinting(){return Je.instance.supportsPrinting},get supportsFullscreen(){var e,t=document.documentElement
return e=!!(t.requestFullscreen||t.mozRequestFullScreen||t.webkitRequestFullScreen||t.msRequestFullscreen),!1!==document.fullscreenEnabled&&!1!==document.mozFullScreenEnabled&&!1!==document.webkitFullscreenEnabled&&!1!==document.msFullscreenEnabled||(e=!1),e&&!0===L.PDFJS.disableFullscreen&&(e=!1),L.shadow(this,"supportsFullscreen",e)},get supportsIntegratedFind(){return this.externalServices.supportsIntegratedFind},get supportsDocumentFonts(){return this.externalServices.supportsDocumentFonts},get supportsDocumentColors(){return this.externalServices.supportsDocumentColors},get loadingBar(){var e=new de("#loadingBar",{})
return L.shadow(this,"loadingBar",e)},get supportedMouseWheelZoomModifierKeys(){return this.externalServices.supportedMouseWheelZoomModifierKeys},initPassiveLoading:function(){throw new Error("Not implemented: initPassiveLoading")},setTitleUsingUrl:function(e){this.url=e,this.baseUrl=e.split("#")[0]
try{this.setTitle(decodeURIComponent(L.getFilenameFromUrl(e))||e)}catch(t){this.setTitle(e)}},setTitle:function(e){this.isViewerEmbedded||(document.title=e)},close:function(){if(this.appConfig.errorWrapper.container.setAttribute("hidden","true"),!this.pdfLoadingTask)return Promise.resolve()
var e=this.pdfLoadingTask.destroy()
return this.pdfLoadingTask=null,this.pdfDocument&&(this.pdfDocument=null,this.pdfThumbnailViewer.setDocument(null),this.pdfViewer.setDocument(null),this.pdfLinkService.setDocument(null,null)),this.store=null,this.isInitialViewSet=!1,this.pdfSidebar.reset(),this.pdfOutlineViewer.reset(),this.pdfAttachmentViewer.reset(),this.findController.reset(),this.findBar.reset(),this.toolbar.reset(),this.secondaryToolbar.reset(),"undefined"!=typeof PDFBug&&PDFBug.cleanup(),e},open:function(e,t){if(arguments.length>2||"number"==typeof t)return Promise.reject(new Error("Call of open() with obsolete signature."))
if(this.pdfLoadingTask)return this.close().then(function(){return pe.reload(),this.open(e,t)}.bind(this))
var i,n=Object.create(null)
if("string"==typeof e?(this.setTitleUsingUrl(e),n.url=e):e&&"byteLength"in e?n.data=e:e.url&&e.originalUrl&&(this.setTitleUsingUrl(e.originalUrl),n.url=e.url),t){for(var s in t)n[s]=t[s]
t.scale&&(i=t.scale),t.length&&this.pdfDocumentProperties.setFileSize(t.length)}var r=this
r.downloadComplete=!1
var a=L.getDocument(n)
return this.pdfLoadingTask=a,a.onPassword=function(e,t){r.passwordPrompt.setUpdateCallback(e,t),r.passwordPrompt.open()},a.onProgress=function(e){r.progress(e.loaded/e.total)},a.onUnsupportedFeature=this.fallback.bind(this),a.promise.then(function(e){r.load(e,i)},function(e){var t=e&&e.message,i=ue.get("loading_error",null,"An error occurred while loading the PDF.")
e instanceof L.InvalidPDFException?i=ue.get("invalid_file_error",null,"Invalid or corrupted PDF file."):e instanceof L.MissingPDFException?i=ue.get("missing_file_error",null,"Missing PDF file."):e instanceof L.UnexpectedResponseException&&(i=ue.get("unexpected_response_error",null,"Unexpected server response."))
var n={message:t}
throw r.error(i,n),new Error(i)})},download:function(){function e(){n.downloadUrl(t,i)}var t=this.baseUrl,i=ce(t),n=this.downloadManager
return n.onerror=function(e){He.error("PDF failed to download.")},this.pdfDocument&&this.downloadComplete?void this.pdfDocument.getData().then(function(e){var s=L.createBlob(e,"application/pdf")
n.download(s,t,i)},e).then(null,e):void e()},fallback:function(e){},error:function(e,t){var i=ue.get("error_version_info",{version:L.version||"?",build:L.build||"?"},"PDF.js v{{version}} (build: {{build}})")+"\n"
t&&(i+=ue.get("error_message",{message:t.message},"Message: {{message}}"),t.stack?i+="\n"+ue.get("error_stack",{stack:t.stack},"Stack: {{stack}}"):(t.filename&&(i+="\n"+ue.get("error_file",{file:t.filename},"File: {{file}}")),t.lineNumber&&(i+="\n"+ue.get("error_line",{line:t.lineNumber},"Line: {{line}}"))))
var n=this.appConfig.errorWrapper,s=n.container
s.removeAttribute("hidden"),n.errorMessage.textContent=e
var r=n.closeButton
r.onclick=function(){s.setAttribute("hidden","true")}
var a=n.errorMoreInfo,o=n.moreInfoButton,h=n.lessInfoButton
o.onclick=function(){a.removeAttribute("hidden"),o.setAttribute("hidden","true"),h.removeAttribute("hidden"),a.style.height=a.scrollHeight+"px"},h.onclick=function(){a.setAttribute("hidden","true"),o.removeAttribute("hidden"),h.setAttribute("hidden","true")},o.oncontextmenu=le,h.oncontextmenu=le,r.oncontextmenu=le,o.removeAttribute("hidden"),h.setAttribute("hidden","true"),a.value=i},progress:function(e){var t=Math.round(100*e);(t>this.loadingBar.percent||isNaN(t))&&(this.loadingBar.percent=t,L.PDFJS.disableAutoFetch&&t&&(this.disableAutoFetchLoadingBarTimeout&&(clearTimeout(this.disableAutoFetchLoadingBarTimeout),this.disableAutoFetchLoadingBarTimeout=null),this.loadingBar.show(),this.disableAutoFetchLoadingBarTimeout=setTimeout(function(){this.loadingBar.hide(),this.disableAutoFetchLoadingBarTimeout=null}.bind(this),5e3)))},load:function(e,t){var i=this
t=t||re,this.pdfDocument=e,this.pdfDocumentProperties.setDocumentAndUrl(e,this.url)
var n=e.getDownloadInfo().then(function(){i.downloadComplete=!0,i.loadingBar.hide()})
this.toolbar.setPagesCount(e.numPages,!1),this.secondaryToolbar.setPagesCount(e.numPages)
var s,r=this.documentFingerprint=e.fingerprint,a=this.store=new be(r)
s=null,this.pdfLinkService.setDocument(e,s)
var o=this.pdfViewer
o.currentScale=t,o.setDocument(e)
var h=o.firstPagePromise,d=o.pagesPromise,c=o.onePageRendered
this.pageRotation=0
var l=this.pdfThumbnailViewer
l.setDocument(e),h.then(function(e){n.then(function(){i.eventBus.dispatch("documentload",{source:i})}),i.loadingBar.setWidth(i.appConfig.viewerContainer),L.PDFJS.disableHistory||i.isViewerEmbedded||(i.viewerPrefs.showPreviousViewOnLoad||i.pdfHistory.clearHistoryState(),i.pdfHistory.initialize(i.documentFingerprint),i.pdfHistory.initialDestination?i.initialDestination=i.pdfHistory.initialDestination:i.pdfHistory.initialBookmark&&(i.initialBookmark=i.pdfHistory.initialBookmark))
var s={destination:i.initialDestination,bookmark:i.initialBookmark,hash:null}
a.initializedPromise.then(function(){var e=null,n=null
if(i.viewerPrefs.showPreviousViewOnLoad&&a.get("exists",!1)){e="page="+a.get("page","1")+"&zoom="+(i.viewerPrefs.defaultZoomValue||a.get("zoom",ae))+","+a.get("scrollLeft","0")+","+a.get("scrollTop","0"),n=a.get("sidebarView",ve.NONE)}else i.viewerPrefs.defaultZoomValue&&(e="page=1&zoom="+i.viewerPrefs.defaultZoomValue)
i.setInitialView(e,{scale:t,sidebarView:n}),s.hash=e,i.isViewerEmbedded||i.pdfViewer.focus()},function(e){console.error(e),i.setInitialView(null,{scale:t})}),d.then(function(){(s.destination||s.bookmark||s.hash)&&(i.hasEqualPageSizes||(i.initialDestination=s.destination,i.initialBookmark=s.bookmark,i.pdfViewer.currentScaleValue=i.pdfViewer.currentScaleValue,i.setInitialView(s.hash)))})}),e.getPageLabels().then(function(t){if(t&&!i.viewerPrefs.disablePageLabels){var n=0,s=t.length
if(s!==i.pagesCount)return void console.error("The number of Page Labels does not match the number of pages in the document.")
for(;n<s&&t[n]===(n+1).toString();)n++
n!==s&&(o.setPageLabels(t),l.setPageLabels(t),i.toolbar.setPagesCount(e.numPages,!0),i.toolbar.setPageNumber(o.currentPageNumber,o.currentPageLabel))}}),d.then(function(){i.supportsPrinting&&e.getJavaScript().then(function(e){e.length&&(console.warn("Warning: JavaScript is not supported"),i.fallback(L.UNSUPPORTED_FEATURES.javaScript))
for(var t=/\bprint\s*\(/,n=0,s=e.length;n<s;n++){var r=e[n]
if(r&&t.test(r))return void setTimeout(function(){window.print()})}})}),Promise.all([c,Re]).then(function(){e.getOutline().then(function(e){i.pdfOutlineViewer.render({outline:e})}),e.getAttachments().then(function(e){i.pdfAttachmentViewer.render({attachments:e})})}),e.getMetadata().then(function(t){var n=t.info,s=t.metadata
i.documentInfo=n,i.metadata=s,console.log("PDF "+e.fingerprint+" ["+n.PDFFormatVersion+" "+(n.Producer||"-").trim()+" / "+(n.Creator||"-").trim()+"] (PDF.js: "+(L.version||"-")+(L.PDFJS.disableWebGL?"":" [WebGL]")+")")
var r
if(s&&s.has("dc:title")){var a=s.get("dc:title")
"Untitled"!==a&&(r=a)}!r&&n&&n.Title&&(r=n.Title),r&&i.setTitle(r+" - "+document.title),n.IsAcroFormPresent&&(console.warn("Warning: AcroForm/XFA is not supported"),i.fallback(L.UNSUPPORTED_FEATURES.forms))})},setInitialView:function(e,t){var i=t&&t.scale,n=t&&t.sidebarView
this.isInitialViewSet=!0,this.pdfSidebar.setInitialView(this.viewerPrefs.sidebarViewOnLoad||0|n),this.initialDestination?(this.pdfLinkService.navigateTo(this.initialDestination),this.initialDestination=null):this.initialBookmark?(this.pdfLinkService.setHash(this.initialBookmark),this.pdfHistory.push({hash:this.initialBookmark},!0),this.initialBookmark=null):e?this.pdfLinkService.setHash(e):i&&(this.pdfViewer.currentScaleValue=i,this.page=1),this.toolbar.setPageNumber(this.pdfViewer.currentPageNumber,this.pdfViewer.currentPageLabel),this.secondaryToolbar.setPageNumber(this.pdfViewer.currentPageNumber),this.pdfViewer.currentScaleValue||(this.pdfViewer.currentScaleValue=ae)},cleanup:function(){this.pdfDocument&&(this.pdfViewer.cleanup(),this.pdfThumbnailViewer.cleanup(),this.pdfViewer.renderer!==je.SVG&&this.pdfDocument.cleanup())},forceRendering:function(){this.pdfRenderingQueue.printing=this.printing,this.pdfRenderingQueue.isThumbnailViewEnabled=this.pdfSidebar.isThumbnailViewVisible,this.pdfRenderingQueue.renderHighestPriority()},beforePrint:function(){if(!this.printService){if(!this.supportsPrinting){var e=ue.get("printing_not_supported",null,"Warning: Printing is not fully supported by this browser.")
return void this.error(e)}if(!this.pdfViewer.pageViewsReady){var t=ue.get("printing_not_ready",null,"Warning: The PDF is not fully loaded for printing.")
return void window.alert(t)}var i=this.pdfViewer.getPagesOverview(),n=this.appConfig.printContainer,s=Je.instance.createPrintService(this.pdfDocument,i,n)
this.printService=s,this.forceRendering(),s.layout()}},get hasEqualPageSizes(){for(var e=this.pdfViewer.getPageView(0),t=1,i=this.pagesCount;t<i;++t){var n=this.pdfViewer.getPageView(t)
if(n.width!==e.width||n.height!==e.height)return!1}return!0},afterPrint:function(){this.printService&&(this.printService.destroy(),this.printService=null),this.forceRendering()},rotatePages:function(e){var t=this.page
this.pageRotation=(this.pageRotation+360+e)%360,this.pdfViewer.pagesRotation=this.pageRotation,this.pdfThumbnailViewer.pagesRotation=this.pageRotation,this.forceRendering(),this.pdfViewer.currentPageNumber=t},requestPresentationMode:function(){this.pdfPresentationMode&&this.pdfPresentationMode.request()},bindEvents:function(){var e=this.eventBus
e.on("resize",V),e.on("hashchange",N),e.on("beforeprint",this.beforePrint.bind(this)),e.on("afterprint",this.afterPrint.bind(this)),e.on("pagerendered",B),e.on("textlayerrendered",E),e.on("updateviewarea",k),e.on("pagechanging",ee),e.on("scalechanging",$),e.on("sidebarviewchanged",D),e.on("pagemode",T),e.on("namedaction",F),e.on("presentationmodechanged",x),e.on("presentationmode",M),e.on("openfile",O),e.on("print",R),e.on("download",A),e.on("firstpage",j),e.on("lastpage",U),e.on("nextpage",H),e.on("previouspage",W),e.on("zoomin",z),e.on("zoomout",q),e.on("pagenumberchanged",G),e.on("scalechanged",Q),e.on("rotatecw",J),e.on("rotateccw",K),e.on("documentproperties",X),e.on("find",Z),e.on("findfromurlhash",Y),e.on("fileinputchange",qe)},bindWindowEvents:function(){var e=this.eventBus
window.addEventListener("wheel",te),window.addEventListener("click",ie),window.addEventListener("keydown",ne),window.addEventListener("resize",function(){e.dispatch("resize")}),window.addEventListener("hashchange",function(){e.dispatch("hashchange",{hash:document.location.hash.substring(1)})}),window.addEventListener("beforeprint",function(){e.dispatch("beforeprint")}),window.addEventListener("afterprint",function(){e.dispatch("afterprint")}),window.addEventListener("change",function(t){var i=t.target.files
i&&0!==i.length&&e.dispatch("fileinputchange",{fileInput:t.target})})}},We=["null","http://mozilla.github.io","https://mozilla.github.io"]
se=function(e){try{var t=new URL(window.location.href).origin||"null"
if(We.indexOf(t)>=0)return
if(new URL(e,window.location.href).origin!==t)throw new Error("file origin does not match viewer's")}catch(e){var i=e&&e.message,n=ue.get("loading_error",null,"An error occurred while loading the PDF."),s={message:i}
throw He.error(n,s),e}}
var ze
ze=function(e){if(e&&0===e.lastIndexOf("file:",0)){He.setTitleUsingUrl(e)
var t=new XMLHttpRequest
t.onload=function(){He.open(new Uint8Array(t.response))}
try{t.open("GET",e),t.responseType="arraybuffer",t.send()}catch(e){He.error(ue.get("loading_error",null,"An error occurred while loading the PDF."),e)}}else e&&He.open(e)}
var qe
qe=function(e){var t=e.fileInput.files[0]
if(!L.PDFJS.disableCreateObjectURL&&"undefined"!=typeof URL&&URL.createObjectURL)He.open(URL.createObjectURL(t))
else{var i=new FileReader
i.onload=function(e){var t=e.target.result,i=new Uint8Array(t)
He.open(i)},i.readAsArrayBuffer(t)}He.setTitleUsingUrl(t.name)
var n=He.appConfig
n.toolbar.viewBookmark.setAttribute("hidden","true"),n.secondaryToolbar.viewBookmarkButton.setAttribute("hidden","true"),n.toolbar.download.setAttribute("hidden","true"),n.secondaryToolbar.downloadButton.setAttribute("hidden","true")}
var Ge,Qe=!1
Ae.then(function(){document.getElementsByTagName("html")[0].dir=ue.getDirection()})
var Je={instance:{supportsPrinting:!1,createPrintService:function(){throw new Error("Not implemented: createPrintService")}}}
e.PDFViewerApplication=He,e.DefaultExernalServices=Ue,e.PDFPrintServiceFactory=Je}(e.pdfjsWebApp={},e.pdfjsWebUIUtils,e.pdfjsWebDownloadManager,e.pdfjsWebPDFHistory,e.pdfjsWebPreferences,e.pdfjsWebPDFSidebar,e.pdfjsWebViewHistory,e.pdfjsWebPDFThumbnailViewer,e.pdfjsWebToolbar,e.pdfjsWebSecondaryToolbar,e.pdfjsWebPasswordPrompt,e.pdfjsWebPDFPresentationMode,e.pdfjsWebPDFDocumentProperties,e.pdfjsWebHandTool,e.pdfjsWebPDFViewer,e.pdfjsWebPDFRenderingQueue,e.pdfjsWebPDFLinkService,e.pdfjsWebPDFOutlineViewer,e.pdfjsWebOverlayManager,e.pdfjsWebPDFAttachmentViewer,e.pdfjsWebPDFFindController,e.pdfjsWebPDFFindBar,e.pdfjsWebDOMEvents,e.pdfjsWebPDFJS)}(this),function(e,t){!function(e,t,i,n,s){function r(e,t,i,n){var s=p.scratchCanvas
s.width=Math.floor(n.width*(150/72)),s.height=Math.floor(n.height*(150/72))
var r=Math.floor(n.width*u)+"px",a=Math.floor(n.height*u)+"px",o=s.getContext("2d")
return o.save(),o.fillStyle="rgb(255, 255, 255)",o.fillRect(0,0,s.width,s.height),o.restore(),t.getPage(i).then(function(e){var t={canvasContext:o,transform:[150/72,0,0,150/72,0,0],viewport:e.getViewport(1),intent:"print"}
return e.render(t).promise}).then(function(){return{width:r,height:a}})}function a(e,t,i){this.pdfDocument=e,this.pagesOverview=t,this.printContainer=i,this.currentPage=-1,this.scratchCanvas=document.createElement("canvas")}function o(e){var t=document.createEvent("CustomEvent")
t.initCustomEvent(e,!1,!1,"custom"),window.dispatchEvent(t)}function h(){p&&(p.destroy(),o("afterprint"))}function d(e,t){var i=document.getElementById("printServiceOverlay"),n=Math.round(100*e/t),s=i.querySelector("progress"),r=i.querySelector(".relative-progress")
s.value=n,r.textContent=l.get("print_progress_percent",{progress:n},n+"%")}function c(){return w||(w=g.register("printServiceOverlay",document.getElementById("printServiceOverlay"),h,!0),document.getElementById("printCancel").onclick=h),w}var l=t.mozL10n,u=t.CSS_UNITS,f=n.PDFPrintServiceFactory,g=i.OverlayManager,p=null
a.prototype={layout:function(){this.throwIfInactive()
var e=(this.pdfDocument,document.querySelector("body"))
e.setAttribute("data-pdfjsprinting",!0),this.pagesOverview.every(function(e){return e.width===this.pagesOverview[0].width&&e.height===this.pagesOverview[0].height},this)||console.warn("Not all pages have the same size. The printed result may be incorrect!"),this.pageStyleSheet=document.createElement("style")
var t=this.pagesOverview[0]
this.pageStyleSheet.textContent="@supports ((size:A4) and (size:1pt 1pt)) {@page { size: "+t.width+"pt "+t.height+"pt;}}",e.appendChild(this.pageStyleSheet)},destroy:function(){p===this&&(this.printContainer.textContent="",this.pageStyleSheet&&this.pageStyleSheet.parentNode&&(this.pageStyleSheet.parentNode.removeChild(this.pageStyleSheet),this.pageStyleSheet=null),this.scratchCanvas.width=this.scratchCanvas.height=0,this.scratchCanvas=null,p=null,c().then(function(){"printServiceOverlay"===g.active&&g.close("printServiceOverlay")}))},renderPages:function(){var e=this.pagesOverview.length,t=function(i,n){if(this.throwIfInactive(),++this.currentPage>=e)return d(e,e),void i()
var s=this.currentPage
d(s,e),r(this,this.pdfDocument,s+1,this.pagesOverview[s]).then(this.useRenderedPage.bind(this)).then(function(){t(i,n)},n)}.bind(this)
return new Promise(t)},useRenderedPage:function(e){this.throwIfInactive()
var t=document.createElement("img")
t.style.width=e.width,t.style.height=e.height
var i=this.scratchCanvas
"toBlob"in i&&!s.PDFJS.disableCreateObjectURL?i.toBlob(function(e){t.src=URL.createObjectURL(e)}):t.src=i.toDataURL()
var n=document.createElement("div")
return n.appendChild(t),this.printContainer.appendChild(n),new Promise(function(e,i){t.onload=e,t.onerror=i})},performPrint:function(){return this.throwIfInactive(),new Promise(function(e){setTimeout(function(){if(!this.active)return void e()
v.call(window),setTimeout(e,20)}.bind(this),0)}.bind(this))},get active(){return this===p},throwIfInactive:function(){if(!this.active)throw new Error("This print request was cancelled or completed.")}}
var v=window.print
window.print=function(){if(p)return void console.warn("Ignored window.print() because of a pending print job.")
c().then(function(){p&&g.open("printServiceOverlay")})
try{o("beforeprint")}finally{if(!p)return console.error("Expected print service to be initialized."),void("printServiceOverlay"===g.active&&g.close("printServiceOverlay"))
var e=p
p.renderPages().then(function(){return e.performPrint()}).catch(function(){}).then(function(){e.active&&h()})}}
var m=!!document.attachEvent
if(window.addEventListener("keydown",function(e){if(80===e.keyCode&&(e.ctrlKey||e.metaKey)&&!e.altKey&&(!e.shiftKey||window.chrome||window.opera)){if(window.print(),m)return
return e.preventDefault(),void(e.stopImmediatePropagation?e.stopImmediatePropagation():e.stopPropagation())}},!0),m&&document.attachEvent("onkeydown",function(e){if(e=e||window.event,80===e.keyCode&&e.ctrlKey)return e.keyCode=0,!1}),"onbeforeprint"in window){var b=function(e){"custom"!==e.detail&&e.stopImmediatePropagation&&e.stopImmediatePropagation()}
window.addEventListener("beforeprint",b),window.addEventListener("afterprint",b)}var w
f.instance={supportsPrinting:!0,createPrintService:function(e,t,i){if(p)throw new Error("The print service is created and active.")
return p=new a(e,t,i)}},e.PDFPrintService=a}(e.pdfjsWebPDFPrintService={},e.pdfjsWebUIUtils,e.pdfjsWebOverlayManager,e.pdfjsWebApp,e.pdfjsWebPDFJS)}(this)}.call(pdfjsWebLibs),"interactive"===document.readyState||"complete"===document.readyState?webViewerLoad():document.addEventListener("DOMContentLoaded",webViewerLoad,!0)
