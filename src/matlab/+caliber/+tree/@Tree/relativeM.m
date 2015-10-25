function M = relativeM(obj, nodefrom, nodeto, statesfrom, statesto)
    % Gets the relative transformation from one node to another
    % states: a Map (node -> state index). Nodes with no state
    % specified are assumed to be in their first state.
    if nargin < 5
        statesto = statesfrom;
    end
    nodefrom = obj.getNode(nodefrom);
    nodeto = obj.getNode(nodeto);
    statesfrom = obj.getStateIndices(statesfrom);
    statesto = obj.getStateIndices(statesto);
    M = nodefrom.relativeM(nodeto, statesfrom, statesto);
end
