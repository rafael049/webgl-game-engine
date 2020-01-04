window.loadOBJfile = (path) ->
    result = void
    xmlhttp = new XMLHttpRequest
    xmlhttp.async = false
    xmlhttp.open "GET", path, false
    xmlhttp.send!

    if xmlhttp.status == 200
        result = xmlhttp.responseText
    else
        console.log "Failed to get model, xml status: " + xmlhttp.status

    return result

window.loadMesh = (name) ->
    data = {}

    data.vertex = []
    _vertex = []

    data.texCoord = []
    _texCoord = []

    data.normal = []
    _normal = []

    vertexIndex = []
    texIndex = []
    normalIndex = []

    data.numVertices = 0

    str = loadOBJfile ("assets/models/" + name + ".obj")
    # str is an array of lines
    str = str.split '\n'

    for line in str
        elements = line.split(" ")
        prefix = elements[0]

        # Vertex positions
        if prefix == "v"
            _vertex = _vertex.concat(
                [ parseFloat(elements[1])
                , parseFloat(elements[2])
                , parseFloat(elements[3])
                ]
            )

        # Unconfigured texture coords
        if prefix == "vt"
            _texCoord = _texCoord.concat(
                [ parseFloat(elements[1])
                , 1 -parseFloat(elements[2])
                ]
            )
        # Indexes (vertex, texCoord and normal)
        if prefix == "f"
            for i from 1 to 3
                indexes = elements[i].split('/')
                vertexIndex = vertexIndex.concat(parseInt(indexes[0]) - 1)
                texIndex = texIndex.concat(parseInt(indexes[1]) - 1)
                normalIndex = normalIndex.concat(parseInt(indexes[2]) - 1)

            data.numVertices += 1

    # Convert to non indexed values
    # Vertex
    for i in vertexIndex
        data.vertex = data.vertex.concat(_vertex[3*i], _vertex[3*i+1], _vertex[3*i+2])
    # Texture coords
    for i in texIndex
        data.texCoord = data.texCoord.concat(_texCoord[2*i], _texCoord[2*i+1])


    data.numVertices = vertexIndex.length
    data

