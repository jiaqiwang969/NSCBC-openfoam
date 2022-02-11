disp('Computing the solution in terms of wave properties and contributions')

for ii=1:length(L);
    [L(ii).PHI(:,:,:),L(ii).Lambda(:,:)] = eigenshuffle(-L(ii).Alpha(:,:,:));
end
%
for i_f=1:length(in.f);
    omega=2*pi*in.f(i_f);
    
    for ii=1:length(L);
        % wave amplitudes
        L(ii).wave.q(:,i_f) = L(ii).PHI(:,:,i_f) \ L(ii).statevector.M(:,i_f);
        L(ii).wave.num(:,i_f) = L(ii).Lambda(:,i_f);
        L(ii).wave.slowness(:,i_f) = real(L(ii).wave.num(:,i_f) ./omega);
        L(ii).wave.attenuation(:,i_f) = -omega.*imag(L(ii).wave.num(:,i_f) ./omega);
        L(ii).wave.length(:,i_f) = real(2*pi./L(ii).wave.num(:,i_f));
        L(ii).wave.pol(:,:,i_f) = L(ii).PHI(:,:,i_f);
    end
end