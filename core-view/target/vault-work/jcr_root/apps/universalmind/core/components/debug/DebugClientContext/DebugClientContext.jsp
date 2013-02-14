<%@ include file="/libs/foundation/global.jsp" %> 

<%@ page session="false" %>
<%--
  ~ Copyright 2012 Mike Nimer & Universal Mind
  ~    Licensed under the Apache License, Version 2.0 (the "License");
  ~    you may not use this file except in compliance with the License.
  ~    You may obtain a copy of the License at
  ~
  ~        http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~    Unless required by applicable law or agreed to in writing, software
  ~    distributed under the License is distributed on an "AS IS" BASIS,
  ~    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~    See the License for the specific language governing permissions and
  ~    limitations under the License.
  --%>

<cq:includeClientLib categories="personalization"/>

<div style="min-height:200px; border 2px solid">
<b>Client Context Debug Dump</b><hr/>

<div style="background-color:#eeeeee; padding:10px;">
    Profile Data:<br/>
    <label for="property-name">Property:</label><input type="text" name="property-name" id="property-name">
    <label for="property-value">Value:</label><input type="text" name="property-value" id="property-value">
    <input type="button" value="save" onClick="propertyFormHandler( $CQ('#property-name').val(), $CQ('#property-value').val() )"/>
    <input type="button" value="persist to server" onClick="persistStoreToServer()"/>
    
</div>

<div class="clientContextDebug"></div>


<script>
CQ_Analytics.ClientContextUtils.onStoreRegistered("socialgraph",function(store)
{    
    dumpStore("social graph", store)
});

CQ_Analytics.ClientContextUtils.onStoreRegistered("activitystream",function(store) 
{
    dumpStore("activity stream", store)
});
 
CQ_Analytics.ClientContextUtils.onStoreRegistered("profile",function(store) 
{
    dumpStore("profile", store)
});

CQ_Analytics.ClientContextUtils.onStoreRegistered("pagedata",function(store) 
{
    dumpStore("pagedata", store)
});

CQ_Analytics.ClientContextUtils.onStoreRegistered("mouseposition",function(store) 
{
    dumpStore("mouseposition", store)
});

CQ_Analytics.ClientContextUtils.onStoreRegistered("eventdata",function(store) 
{
    dumpStore("eventdata", store)
});

CQ_Analytics.ClientContextUtils.onStoreRegistered("tagcloud",function(store) 
{
    dumpStore("tagcloud", store)
});

CQ_Analytics.ClientContextUtils.onStoreRegistered("surferinfo",function(store) 
{
    dumpStore("surfer info", store)
});

CQ_Analytics.ClientContextUtils.onStoreRegistered("segments",function(store) 
{
    dumpStore("segments", store)
});

CQ_Analytics.ClientContextUtils.onStoreRegistered("geolocation",function(store) 
{
    dumpStore("geolocation", store)
});



CQ_Analytics.ClientContextUtils.onStoreInitialized("profile",function(store) {
  
  var _store = CQ_Analytics.ClientContext.get("profile");
  // add update listener to store
  _store.addListener("update", function(store, property) 
  {
    //property might be null if store is fully updated (init, reset or clear cases)
    if( property != null )
    {
        var prop = $CQ("#" +property);
        if( prop != null )
        {
            prop.html( _store.getProperty(property) );
        }else{
            prop.append("<li>" +property +":     <span id=" +property +">" +_store.getProperty(property) +"</span></li>");
        }
        //alert(prop.html);
    }
    //in this callback method, "this" is "executionContext" 
  },this);

}, true);


function updateForm(key, val)
{
    $CQ("#property-name").val(key);
    $CQ("#property-value").val(val);
}
  
function propertyFormHandler( propertyName, propertyValue )
{
    var _store = CQ_Analytics.ClientContext.get("profile"); 
    _store.setProperty(propertyName, propertyValue);   
}

  
function persistStoreToServer( propertyName, propertyValue )
{
    // Save back to the server
    CQ_Analytics.ClientContext.persist("profile");
    
}


function dumpStore(title, store)
{
    var dumpDiv = $CQ("#clientContextDump");
    dumpDiv.append("<b>" +title +"</b><br/>");
    var list = "<ul>";
    for( var key in store.data)
    {
        var storeProps = store.data[key];
        list += "<li>";
        if( title == "profile" )
        {
            list += "<input type='button' value='edit' onclick='updateForm(\"" +key +"\",\"" +store.data[key] +"\")'/>";
        }
        list += key +": <span id=" +key +">" +store.data[key] +"</span>";
        list += "</li>";
    }
    list += "</ul>";
    dumpDiv.append(list);
}
</script>

</div>