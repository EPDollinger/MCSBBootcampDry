for nt=1:numel(T)
   figure(5); clf; hold on; box on;
   plot(X(nt,1:10));
   set(gca,'ylim', [-2.5,2.5])
   xlabel('Cell');
   ylabel('Voltage')
   time = round(nt/length(X)*100);
   text(2,2,['T = ',num2str(time),' s']);
   drawnow;
end