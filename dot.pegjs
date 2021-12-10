/*
PEG.js (version 0.10) for GraphViz DOT.
Empty properties are absent from parsed objects.
All atomic values are strings.
Keywords are made case insensitive according to DOT documentation and contrary to GraphViz implementation (e.g. version 2.38).
Quoted strings preserve non-escaped line breaks according to DOT documentation and GraphViz implementation version 2.38, but not e.g. version 2.46.
*/

file
	= _ x:graph+ { return x }
	
graph
	= strict:('strict'i _)? type:('graph'i / 'digraph'i) _ name:ID? '{' _ stmt_list:stmt_list '}' _ {
		var o = {
			strict: !!strict,
			type: type.toLowerCase()
		}
		if (name) o.name = name;
        if (stmt_list.length) o.stmt_list = stmt_list;
		return o
	}
	
subgraph
	= name:('subgraph'i _ x:ID? { return x })? '{' _ stmt_list:stmt_list '}' _ {
		var o = { type: 'subgraph' }
		if (name) o.name = name;
        if (stmt_list.length) o.stmt_list = stmt_list;
		return o
	}
	
stmt_list
	= (x:stmt (';' _)? { return x })*
	
stmt
	= attr_stmt
 	/ edge_stmt
	/ subgraph
 	/ x:ID '=' _ y:ID {
        var o = {
            type: 'attr_stmt',
            target: 'graph',
            attr_list: {}
	    }
	    o.attr_list[x.value] = y;
	    return o
	}
 	/ node_stmt
	
attr_stmt
	= target:('graph'i / 'node'i / 'edge'i) _ attr_list:attr_list {
		return {
			type: 'attr_stmt',
			target: target.toLowerCase(),
			attr_list: attr_list
		}
	}
	
attr_list
	= attr_list:('[' _ attr* ']' _)+ {
		var o = {};
		var empty = true;
		attr_list.forEach(function (a_list) {
			a_list[2].forEach(function (attr) {
				o[attr[0].value] = attr[3];
				empty = false;
			});
		});
		return (empty)? null : o
	}
	
attr
	= ID '=' _ ID ([;,] _)?
	
edge_stmt
	= x:(subgraph / node_id) y:edgeRHS attr_list:attr_list? {
		y.unshift(x);
        var o = {
			type: 'edge_stmt',
            edge_list: y
		}
        if (attr_list) o.attr_list = attr_list;
		return o
	}
	
edgeRHS
	= (edgeop x:(subgraph / node_id) { return x })+

	
node_stmt
	= node_id:node_id attr_list:attr_list? {
		var o = {
			type: 'node_stmt',
            node_id: node_id
		}
        if (attr_list) o.attr_list = attr_list;
		return o
	}
	
node_id
	= name:ID port:port? compass_pt:port? {
		var o = {
			type: 'node_id',
            name: name
		}
        if (port !== null) o.port = port;
        if (compass_pt !== null) o.compass_pt = compass_pt;
		return o
	}
	
port
	= ':' _ x:ID { return x.value }
	
edgeop
	= ('--' / '->') _
	
ID
	=  HTML
 	/ QUOTED
 	/ NUMERAL
 	/ STRING
	
HTML
	= '<' x:$(![<>] . / HTML)* '>' _ {
    	return {
        	type: 'html',
            value: x
        }
    }
	
QUOTED
	= '"' x:ESCAPED* '"' _ y:('+' _ '"' z:ESCAPED* '"' _ { return z.join('') })* {
    	return {
        	type: 'quoted',
            value: x.join('') + y.join('')
        }
    }
	
ESCAPED
	= ESC_QUOTE
 	/ ESC_EOL
	/ $('\\' .)
 	/ [^"]
	
ESC_QUOTE
	= '\\"' { return '"' }
	
ESC_EOL
	= '\\' EOL { return '' } // Discarding every EOL is undocumented. Seems like 2.46.0 bug: '\\' EOL
	
NUMERAL
	= x:$('-'? ([0-9]+ ('.' [0-9]*)? / '.' [0-9]+)) _ {
    	return {
        	type: 'numeral',
            //value: parseFloat(text()) GraphViz shows preserved formatting!
			value: x
        }
    }
	
STRING
	= x:$[^{}\[\]<>"=\-;,: \n\r\t#/]+ _ { // Lax negative class for ([A-Z_a-z\x80-\uFFFF] [0-9A-Z_a-z\x80-\uFFFF]*)
    	return {
        	type: 'string',
            value: x
        }
    }
	
_
	= ([ \n\r\t] / COMMENT)* // Concise lax for ([ \t] / EOL / COMMENT)*
	
COMMENT
	= COMMENT_HASH
 	/ COMMENT_SLASH
 	/ COMMENT_BLOCK
	
COMMENT_HASH
	= '#' (!EOL .)*
	
COMMENT_SLASH
	= '//' (!EOL .)*
	
COMMENT_BLOCK
	= '/*' (!'*/' .)* '*/'
	
EOL
	= [\n\r]+ // Concise lax class for '\r\n' / '\n' / '\r'
