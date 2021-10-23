ArrayList<Node> nodes = new ArrayList<Node>();
ArrayList<Node> visitedNodes = new ArrayList<Node>();
ArrayList<State> states = new ArrayList<State>();
int goalIndex = 0;
State initalState = new State(3, 3, "L");
State goalState = new State(0, 0, "R");
ArrayList<Integer> status = new ArrayList<Integer>();

void setup() {
  size(350, 700); //size of the window
  background(255);
  frameRate(30);

  //add root
  states.add(initalState);
  nodes.add(new Node(initalState, 0, -1, false, 0));
  int size = 1;
  while (true) {
    boolean flag = false;
    Node cur = nodes.get(0);

    for (int j = 0; j < visitedNodes.size(); j++) {
      if (cur.getState().isEqual(visitedNodes.get(j).getState())) {
        //parent1 = i;
        flag = true;
        break;
      }
    }
    println("--------");
    print("Current state: ");
    nodes.get(0).getState().printState();
    if (nodes.get(0).getState().isEqual(goalState)) {
      goalIndex = 0;
      println("GOAL STATE");
      nodes.get(0).setVisited(true);
      visitedNodes.add(nodes.get(0));
      nodes.remove(0);
      break;
    }
    //if valid
    if (nodes.get(0).getState().isValid()) {

      //if not visited
      if (!flag) {

        State[] nextStates = nodes.get(0).getState().nextStates();
        Node parNode = nodes.get(0);
        for (int j = 0; j < nextStates.length; j++) {
          //visit the node
          nodes.add(new Node(nextStates[j], ++size, parNode.getID(), false, parNode.getDepth()+1));
        }
      } else {
        println("Visited Before");
      }
    } else {
      println("Not a valid state");
    }
    nodes.get(0).setVisited(true);
    visitedNodes.add(nodes.get(0));
    nodes.remove(0);
    nodes = bubbleSort(nodes);
    println("--------");
  }
  //Visualizing the graph on GUI

  //Graph Legend:
  //LIGHT BLUE: Root node
  //RED: Not a valid node
  //BLUE: Previously visited node
  //BLACK: Node with children
  //GRAY: A node on the answer path
  //GREEN: Goal node
  int v = 1;
  int y = 0;
  int[] parentNodeNumber = new int[visitedNodes.size()];
  parentNodeNumber[0] = -1;
  for (int x = 1; x < visitedNodes.size(); x++) {
    boolean flag = false;
    State cur = visitedNodes.get(x).getState();

    for (int i = 0; i < x; i++) {
      if (cur.isEqual(visitedNodes.get(i).getState())) {
        flag = true;
      }
    }
    if (nodes.get(x).getState().isValid()) {
      if (!flag) {

        status.add(0);
      } else {
        status.add(2);
      }
    } else {
      status.add(-1);
    }

parentNodeNumber[x] = nodes.get(x).g
    for (int k = 0; k < x; k++) {
      if (nodes.get(x).getParent().isEqual(nodes.get(k))) {
        parentNodeNumber[x] = k;
        break;
      }
    }
  }

  for (int i =0; i < visitedNodes.size(); i++) {
    fill(0);
    text(visitedNodes.get(i).getState().stateString(), 30, 30+(v*50));
    v++;
  }
}
ArrayList<Node> bubbleSort(ArrayList<Node> arr)
{
  int n = arr.size();
  for (int i = 0; i < n-1; i++)
    for (int j = 0; j < n-i-1; j++)
      if (arr.get(j).getCost() > arr.get(j+1).getCost())
      {
        // swap arr[j+1] and arr[j]
        Node temp = arr.get(j);
        arr.set(j, arr.get(j+1));
        arr.set(j+1, temp);
      }
  return arr;
}
