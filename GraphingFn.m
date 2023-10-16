% function for use in Graphing Predator AND prey account over time
function GraphingFn(t,PredPray,GraphTitle)

graph=tiledlayout(1,2);

nexttile
plot(t,PredPray);
title("Parasite and Food Overtime");
xlabel("Time t")
ylabel("Species #")
legend("Parasite (X1)","Food (X2)","Location","southeast")

nexttile
plot(PredPray(:,1),PredPray(:,2));
title("Parasite Vs Food (phase)");
ylabel("Food #")
xlabel("Parasite #")

title(graph,GraphTitle)

end
