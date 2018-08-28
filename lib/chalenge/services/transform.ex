defmodule Chalenge.TransformService do
    def iterateBranch(params,parentId) do
        indexs = Map.keys(params)
        if length(indexs) > 0 do
            head = hd indexs
            tail = Map.delete(params, head)
            iterateLevel(tail,params[head],parentId)
        else
            []
        end
    end

    def iterateLevel(_,[], _) do [] end
    def iterateLevel(list,[head | tail], parentId) do
        if isChild(head, parentId) do
            head = appendChild(list,head)
            [head] ++ iterateLevel(list,tail, parentId)
        else
            iterateLevel(list,tail, parentId)
        end
    end

    def isChild(item,parentId) do
        item["parent_id"] == parentId
    end

    def appendChild(list,head) do
        Map.put(head, "children", iterateBranch(list,head["id"]))
    end
end
