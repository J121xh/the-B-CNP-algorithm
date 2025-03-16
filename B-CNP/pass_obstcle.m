function lineIntersectsObstacle=pass_obstcle(gridMap,point1,point2)

lineIntersectsObstacle = false;

for x = min(point1(1), point2(1)):max(point1(1), point2(1))
    for y = min(point1(2), point2(2)):max(point1(2), point2(2))
        if gridMap(x, y) == 1
            lineIntersectsObstacle = true;
            break;
        end
    end
    if lineIntersectsObstacle
        break;
    end
end

end