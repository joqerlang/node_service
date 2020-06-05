%%% -------------------------------------------------------------------
%%% @author : joqerlang
%%% @doc : ets dbase for master service to manage app info , catalog  
%%%
%%% -------------------------------------------------------------------
-module(nodes).
 


%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------


-include("common_macros.hrl").

%-compile(export_all).
-export([available/0,missing/1,obsolite/1]).




%% ====================================================================
%% External functions
%% ====================================================================
%% --------------------------------------------------------------------
%% 
%% 
%% {"master_sthlm_1",'master_sthlm_1@asus'}
%% --------------------------------------------------------------------
%% @doc: available get active nodes in the cluster

-spec(available()->[{NodeId::string(),Node::atom()}]| []).
available()->
    AvailableNodes=[node()|nodes()],
    Node_NodeId_Host=[{Node,string:split(atom_to_list(Node),"@")}||Node<-AvailableNodes],
    NodeId_Node=[{NodeId,Node}||{Node,[NodeId,_Host]}<-Node_NodeId_Host],
    NodeId_Node.


%% @doc: missing nodes in the cluster

-spec(missing(AllNodes::tuple())->[{NodeId::string(),Node::atom()}]| []).
missing(AllNodes)->
    AvailableNodes=available(),
    Missing=[{NodeId,Node}||{NodeId,Node}<-AllNodes,
			    false==lists:member({NodeId,Node},AvailableNodes)],
    Missing.

%% @doc: obsolite nodes in the cluster

-spec(obsolite(AllNodes::tuple())->[{NodeId::string(),Node::atom()}]| []).
obsolite(AllNodes)->
    AvailableNodes=available(),
    Obsolite=[{NodeId,Node}||{NodeId,Node}<-AvailableNodes,
			    false==lists:member({NodeId,Node},AllNodes)],
    Obsolite.
