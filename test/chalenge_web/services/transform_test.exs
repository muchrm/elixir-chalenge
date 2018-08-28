defmodule ChalengeWeb.TransformServiceTest do
  use ChalengeWeb.ConnCase, async: true
  test "iterateBranch" do
    assert Chalenge.TransformService.iterateBranch(%{
    "0":
    [%{id: 10,
      parent_id: nil}],
    "1":
    [%{id: 12,
      parent_id: 10},
     %{id: 18,
      parent_id: 10},
     %{id: 13,
      parent_id: 10}],
    "2":
    [%{id: 17,
      parent_id: 12},
     %{id: 16,
      parent_id: 13},
     %{id: 15,
      parent_id: 12}]}, nil)
      ==
      [%{id: 10,
      children:
       [%{id: 12,
         children:
          [%{id: 17,
            children: [],
            parent_id: 12},
           %{id: 15,
            children: [],
            parent_id: 12}],
         parent_id: 10},
        %{id: 18,
         children: [],
         parent_id: 10},
        %{id: 13,
         children:
          [%{id: 16,
            children: [],
            parent_id: 13}],
         parent_id: 10}],
      parent_id: nil}]
  end
  test "iterateLevel" do
    assert Chalenge.TransformService.iterateLevel(%{},[
      %{id: 17,parent_id: 12},
      %{id: 16,parent_id: 13},
      %{id: 15,parent_id: 12}
      ],12)
      == [
      %{children: [], id: 17, parent_id: 12},
      %{children: [], id: 15, parent_id: 12}
      ]
  end
end
