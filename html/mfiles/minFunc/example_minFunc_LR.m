clear all

nInst = 500;
nVars = 200;
X = randn(nInst,nVars);
w = randn(nVars,1);
y = sign(X*w + randn(nInst,1));

w_init = zeros(nVars,1);
funObj = @(w)LogisticLoss(w,X,y);

fprintf('Running Steepest Descent\n');
options.Method = 'sd';
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Cyclic Steepest Descent\n');
options.Method = 'csd';
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Conjugate Gradient\n');
options.Method = 'cg';
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Scaled Conjugate Gradient\n');
options.Method = 'scg';
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Preconditioned Conjugate Gradient (Diagonal preconditioner)\n');
options.Method = 'pcg';
options.precFunc = @LogisticDiagPrecond;
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Preconditioned Conjugate Gradient (L-BFGS preconditioner)\n');
options.Method = 'pcg';
options.precFunc = [];
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Hessian-Free Newton w/ numerical Hessian-Vector products\n');
options.Method = 'newton0';
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Preconditioned Hessian-Free Newton w/ numerical Hessian-Vector products (Diagonal preconditioner)\n');
options.Method = 'pnewton0';
options.precFunc = @LogisticDiagPrecond;
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Preconditioned Hessian-Free Newton w/ numerical Hessian-Vector products (L-BFGS preconditioner)\n');
options.Method = 'pnewton0';
options.precFunc = [];
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Hessian-Free Newton w/ numerical Hessian-Vector products\n');
options.Method = 'newton0';
options.HvFunc = @LogisticHv;
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Preconditioned Hessian-Free Newton w/ numerical Hessian-Vector products (Diagonal preconditioner)\n');
options.Method = 'pnewton0';
options.HvFunc = @LogisticHv;
options.precFunc = @LogisticDiagPrecond;
minFunc(@LogisticLoss,w_init,options,X,y);
pause;

fprintf('Running Preconditioned Hessian-Free Newton w/ numerical Hessian-Vector products (L-BFGS preconditioner)\n');
options.Method = 'pnewton0';
options.precFunc = [];
options.HvFunc = @LogisticHv;
minFunc(@LogisticLoss,w_init,options,X,y);
pause;