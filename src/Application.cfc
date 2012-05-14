<cfcomponent extends="coldbox.system.Coldbox" output="false">

	<cfset this.root = replace(getDirectoryFromPath(getMetadata(this).path), "\", "/", "all")/>
	<cfset this.parent = reReplace(this.root, "/[^/]+/$", "/")/>

	<cfset this.name = "automaton_#hash(this.root, 'MD5')#"/>
	<cfset this.applicationTimeout = createTimespan(2, 0, 0, 0)/>
	<cfset this.sessionManagement = true/>
	<cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0)/>
	<cfset this.setClientCookies = false/>
	<cfset this.datasource = "@DATASOURCE@"/>

	<cfset this.mappings = structNew()/>
	<cfset this.mappings["/model"] = this.root & "model"/>
	<cfset this.mappings["/taglib"] = this.root & "taglib"/>
	<cfset this.mappings["/plugins"] = this.root & "plugins"/>
	<cfset this.mappings["/udfs"] = this.root & "udfs"/>

	<cfset COLDBOX_APP_ROOT_PATH = this.root/>
	<cfset COLDBOX_APP_MAPPING = ""/>
	<cfset COLDBOX_CONFIG_FILE = ""/>
	<cfset COLDBOX_APP_KEY = ""/>

	<cffunction name="onApplicationStart" returntype="boolean" access="public" output="false">
		<cfset request.connection = getConnectionInspector().getConnectionMemento()/>
		<cfset loadColdBox()/>
		<cfreturn true/>
	</cffunction>

	<cffunction name="onRequestStart" returntype="boolean" access="public" output="true">
		<cfargument name="targetPage" type="string" required="true"/>

		<cfif not structKeyExists(request, "connection")>
			<cfset request.connection = getConnectionInspector().getConnectionMemento()/>
		</cfif>
		<cfset reloadChecks()/>
		<cfif findNoCase("index.cfm", listLast(arguments.targetPage, '/'))>
			<cfset processColdBoxRequest()/>
		</cfif>
		<cfreturn true/>
	</cffunction>

	<cffunction name="getConnectionInspector" returntype="ConnectionInspector" access="private" output="false">
		<cfif not structKeyExists(application, "connectionInspector") or structKeyExists(url, "fwreinit")>
			<cfset application.connectionInspector = createObject("component", "ConnectionInspector").init()/>
		</cfif>
		<cfreturn application.connectionInspector/>
	</cffunction>

</cfcomponent>