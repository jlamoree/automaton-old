<cfcomponent>

	<cfset this.root = replace(getDirectoryFromPath(getMetadata(this).path), "\", "/", "all")/>
	<cfset this.parent = reReplace(this.root, "/[^/]+/$", "/")/>

	<cfset this.name = "automaton_test_#hash(this.root, 'MD5')#"/>
	<cfset this.applicationTimeout = createTimespan(0, 0, 0, 30)/>
	<cfset this.sessionManagement = false/>
	<cfset this.setClientCookies = false/>
	<cfset this.datasource = "@DATASOURCE@"/>

	<cffunction name="onRequestStart" returntype="boolean" access="public" output="true">
		<cfargument name="targetPage" type="string" required="true"/>

		<cfreturn true/>
	</cffunction>

</cfcomponent>