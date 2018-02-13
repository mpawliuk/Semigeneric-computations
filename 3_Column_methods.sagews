import itertools

#################################
### 1. The graph on 3 columns ###
#################################

S = DiGraph( {  0:[4,5,8,9],
                1:[4,5,10,11],
                2:[6,7,8,9],
                3:[6,7,10,11],
                4:[2,3,8,10],
                5:[2,3,9,11],
                6:[0,1,8,10],
                7:[0,1,9,11],
                8:[1,3,5,7],
                9:[1,3,4,6],
               10:[0,2,5,7],
               11:[0,2,4,6]
            } )

# This creates nice positioning for displaying the graph
pos_dict = {}
for i in range(3):
    for j in range(4):
        scale_h = 4
        scale_v = 4
        pos_dict[4*i + j] = [scale_h*i,scale_v*j]

# This gives the vertices colours based on which column they are in
d = {'#FF0000':[0,1,2,3], '#FFFF00':[4,5,6,7], '#FFFFFF':[8,9,10,11]}

# This plots the graph
S.graphplot(pos=pos_dict, vertex_colors=d).show()

########################
### 2. Transversals  ###
########################

def is_linear(graph, transversal):
    """Check if the subgraph is a linear order and return that order."""
    for i in range(3):
        x = transversal[i]
        y = transversal[(i+1)%3]
        z = transversal[(i+2)%3]
        if (x,y) in graph.edges(labels=False) and (x, z) in graph.edges(labels=False):
            # x is the minimal element
            if (y,z) in graph.edges(labels=False):
                return x,y,z
            else:
                return x,z,y
    return False

def all_transversals():
    """Output all 48 linear transversals of S"""
    for i in range(0,4):
        for j in range(4,8):
            for k in range(8,12):
                if is_linear(S,(i,j,k)):
                    yield is_linear(S,(i,j,k))

###########################
### 3. Type of a point  ###
###########################

def column_index(point, transversal):
    """Tell me which column the point is in, relative to the transversal"""
    point_range = point // 4
    for i in range(3):
        if transversal[i] in range(4*point_range, 4*point_range + 4):
            return i

def type(point, transversal):
    """Compute the type of a vertex."""
    column_i = column_index(point, transversal)
    if column_i == 0:
        return (point, transversal[1]) in S.edges(labels=False), (point, transversal[2]) in S.edges(labels=False)
    if column_i == 1:
        return (transversal[0], point) in S.edges(labels=False), (point, transversal[2]) in S.edges(labels=False)
    if column_i == 2:
        return (transversal[0], point) in S.edges(labels=False), (transversal[1], point) in S.edges(labels=False)

########################
### 4. Autmorphisms  ###
########################

def same_type(pair1, pair2):
    """Check if both edges are pointing the same way"""
    if pair1 in S.edges(labels=False) and pair2 in S.edges(labels=False):
        return True
    if not pair1 in S.edges(labels=False) and not pair2 in S.edges(labels=False):
        return True
    return False

def is_automorphism(bijection):
    """Check if a given bijection preserves the structure"""
    for i in range(0,4):
        for j in range(4,12):
            x = bijection[i]
            y = bijection[j]
            if not same_type((i,j),(x,y)):
                return False
    for i in range(4,8):
        for j in range(8,12):
            x = bijection[i]
            y = bijection[j]
            if not same_type((i,j),(x,y)):
                return False
    return True

def all_bijections():
    """Yield all bijections that respect non-edge"""
    for col in itertools.permutations(range(3)):
        a = 4*col[0]
        b = 4*col[1]
        c = 4*col[2]
        for A in itertools.permutations(range(a,a+4)):
            for B in itertools.permutations(range(b,b+4)):
                for C in itertools.permutations(range(c,c+4)):
                    yield A + B + C

def all_automorphisms():
    """Produce all 48 automorphisms.
    - This is a brute-force method.
    - The only optimization is that it sends columns to columns.
    """
    for f in all_bijections():
        if is_automorphism(f):
            yield f
