// ---- Types ----
export type NodeType = "group" | "file" | "text";

export interface SpriteNode {
  id: string;
  type: NodeType;
  x: number;
  y: number;
  width: number;
  height: number;

  // optional fields depending on node type
  label?: string;
  file?: string;
  text?: string;
  color?: string;
}

export interface SpriteEdge {
  id: string;
  fromNode: string;
  fromSide: "left" | "right" | "top" | "bottom";
  toNode: string;
  toSide: "left" | "right" | "top" | "bottom";
}

export interface SpriteData {
  nodes: SpriteNode[];
  edges: SpriteEdge[];
}

// ---- Class ----
export class Sprite {
  private nodes: Map<string, SpriteNode>;
  private edges: SpriteEdge[];

  constructor(data: SpriteData) {
    this.nodes = new Map(data.nodes.map(n => [n.id, n]));
    this.edges = data.edges;
  }

  // ---- Node Access ----
  getNode(id: string): SpriteNode | undefined {
    return this.nodes.get(id);
  }

  get Nodes(): SpriteNode[] {
    return Array.from(this.nodes.values());
  }

  // ---- Edge Access ----
  getEdge(index: number): SpriteEdge | undefined {
    return this.edges[index];
  }

  get Edges(): SpriteEdge[] {
    return this.edges;
  }

  // ---- Indexed Access ----
  Edge(index: number): SpriteEdge | undefined {
    return this.edges[index];
  }

  Node(id: string): SpriteNode | undefined {
    return this.nodes.get(id);
  }

  // ---- Combined View ----
  getCombined() {
    return this.edges.map(edge => ({
      edge,
      from: this.getNode(edge.fromNode),
      to: this.getNode(edge.toNode)
    }));
  }

  // ---- Graph Helpers ----
  getConnections(nodeId: string) {
    return this.edges.filter(
      e => e.fromNode === nodeId || e.toNode === nodeId
    );
  }

  getNeighbors(nodeId: string): SpriteNode[] {
    const connectedIds = this.getConnections(nodeId).map(e =>
      e.fromNode === nodeId ? e.toNode : e.fromNode
    );

    return connectedIds
      .map(id => this.getNode(id))
      .filter((n): n is SpriteNode => !!n);
  }
}
