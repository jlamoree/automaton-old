<cfsilent>
	<cfset colddoc = createObject("component", "colddoc.ColdDoc").init()/>
	<cfset strategy = createObject("component", "colddoc.strategy.api.HTMLAPIStrategy").init(expandPath("/doc/html"), "The Automaton")/>
	<cfset colddoc.setStrategy(strategy)/>
	<cfset colddoc.generate(expandPath("/model"), "model")/>
</cfsilent>