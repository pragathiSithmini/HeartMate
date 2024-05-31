from prediction import predict

def test_predict():
    parameters = [[45, 120, 1, 70, 140, 0, 1, 190, 1, 30.5]]
    result = predict(parameters)
    assert result in ["Negative", "Positive"]

    parameters = [[57, 105, 0, 87, 96, 1, 1, 246, 1, 41]]
    result = predict(parameters)
    assert result in ["Negative", "Positive"]

    parameters = [[60, 97, 1, 119, 83, 0, 0, 182, 1, 33.5]]
    result = predict(parameters)
    assert result in ["Negative", "Positive"]

    parameters = [[83, 137, 1, 70, 140, 0, 0, 190, 1, 37.5]]
    result = predict(parameters)
    assert result in ["Negative", "Positive"]

    parameters = [[62, 157, 1, 90, 68, 0, 0, 275, 0, 23.8]]
    result = predict(parameters)
    assert result in ["Negative", "Positive"]

    parameters = [[33, 132, 0, 80, 68, 1, 1, 204, 1, 19.5]]
    result = predict(parameters)
    assert result in ["Negative", "Positive"]

    parameters = [[45, 120, 0, 70, 140, 0, 0, 190,0, 30.5]]
    result = predict(parameters)
    assert result in ["Negative", "Positive"]

    parameters = [[20, 141, 0, 99, 94, 0, 1, 262, 0, 22.9]]
    result = predict(parameters)
    assert result in ["Negative", "Positive"]

    parameters = [[61, 124, 1, 94, 140, 1, 0, 237, 0, 29.3]]
    result = predict(parameters)
    assert result in ["Negative", "Positive"]

    parameters = [[48, 109, 100, 80, 108, 0, 1, 190, 0, 36.5]]
    result = predict(parameters)
    assert result in ["Negative", "Positive"]

