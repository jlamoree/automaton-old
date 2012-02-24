<cfsilent>

	<cfset setBaseURL("@DEPLOY_BASEURL@")/>
	<cfset setUniqueURLs(false)/>
	<cfset addRoute(pattern=":handler/:action?")/>

</cfsilent>