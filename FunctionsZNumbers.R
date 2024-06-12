alpha.cut = function(dfn,x){
  y= which(dfn >= x)
  return(c(min(y),max(y)))
}


core = function(dfn){
  y=which(dfn==1)
  return(c(min(y),max(y)))
}


increasing.generation = function(y,length.dfn){
  vectors=c()
  aux=c()
  n=length(y)
    for (i in 1:n){
    aux=c(aux,y[1])
    if(length(aux) == length.dfn) {
      vectors=rbind(vectors,aux)
      aux=c()
    } else {
      aux2=increasing.generation(y,length.dfn-1)
      m=dim(aux2)[1]
      vectors=rbind(vectors,cbind(rep(y[1],m),aux2))
    }
    y=y[-1]
    aux=c()
    }
  rownames(vectors)=c()
  return(vectors)
}


decreasing.generation = function(y,length.dfn){
  vectors=increasing.generation(y,length.dfn)
  if (length.dfn !=1){
    vectors=t(apply(vectors,1,rev))
   } 
  return(vectors)
}


all.dfns = function(y,n){
  generated.dfns=c()
  if (n>=3){
    for (i in 2:(n-1)){
      left.piece = increasing.generation(y,i-1)
      for (j in i:(n-1)){
        # core is [i,j]
        right.piece = decreasing.generation(y,n-j)
        for (k in 1:dim(left.piece)[1]){
          for (l in 1:dim(right.piece)[1]){
            aux=c(left.piece[k,],rep(1,j-i+1),right.piece[l,])
            generated.dfns=rbind(generated.dfns,aux)
          }
        }
      }
    }
  }
  for (i in 1:(n-1)){
    right.piece2 = decreasing.generation(y,n-i)
    for (j in 1:dim(right.piece2)[1]){
      aux=c(rep(1,i),right.piece2[j,])
      generated.dfns=rbind(generated.dfns,aux)
    }
  }


  for (j in 1:(n-1)){
    left.piece = increasing.generation(y,j)
    for (i in 1:dim(left.piece)[1]){
      aux=c(left.piece[i,],rep(1,n-j))
      generated.dfns=rbind(generated.dfns,aux)
    }
  }


  generated.dfns=rbind(generated.dfns,rep(1,n))
  rownames(generated.dfns)=c()
  # View(generated.dfns)
  return(generated.dfns)
}

sort.dfns = function(dfn1,dfn2,y){
  y.rev = rev(y)
  y.rev =c(1,y.rev)
  indicador = 0
  j=1
  while(indicador ==0){
    alpha.cut1 = alpha.cut(dfn1,y.rev[j])
    alpha.cut2 = alpha.cut(dfn2,y.rev[j])
    if(norm(alpha.cut1-alpha.cut2,"2")>0){
      indicador=1
      }
    j=j+1
  }
  if(alpha.cut1[1] != alpha.cut2[1]){
    if(alpha.cut1[1] < alpha.cut2[1]){
      return(TRUE)
    }
  else{
    return(FALSE)
      }
    }
  if(alpha.cut1[1] == alpha.cut2[1]){
    if(alpha.cut1[2] < alpha.cut2[2]){
      return(TRUE)
    }
    else{
      return(FALSE)
    }
  }
}


mmerge<-function(a,b,y) {
  if(!("matrix" %in% class(a))){a=matrix(a,nrow=1)}
  if(!("matrix" %in% class(b))){b=matrix(b,nrow=1)}
  r = matrix(0,nrow=dim(a)[1]+dim(b)[1],ncol=dim(a)[2])
  ai<-1; bi<-1; j<-1;
  for(j in 1:(dim(r)[1])) {
    if((ai<= dim(a)[1] & 
        ifelse(bi<= dim(b)[1] & ai<=dim(a)[1],sort.dfns(b[bi,],a[ai,],y),FALSE)) || 
       bi>dim(b)[1]) {
        r[j,] <- a[ai,]
        ai <- ai+1
      } else {
        r[j,] <- b[bi,]
        bi <- bi+1 
      }
    }
  return(r)
}

mmergesort<-function(A,y) {
  if(!("matrix" %in% class(A))){A=matrix(A,nrow=1)}
  if(dim(A)[1]>1) {
    q <- ceiling(dim(A)[1]/2)
    a <- mmergesort(A[1:q,],y)
    b <- mmergesort(A[(q+1):(dim(A)[1]),],y)
    mmerge(a,b,y)
  } else {
    return(A)
  }
}

# n=4
# #y=seq(from=0,to=0.75,by=0.25)
# y=c(0,0.33)
# generated.dfns = all.dfns(y,n)
# 
# sorted.generated.dfns=mmergesort(generated.dfns,y)
# # View(sorted.generated.dfns)
# sorted.generated.dfns.backwards=sorted.generated.dfns[dim(sorted.generated.dfns)[1]:1,]
# View(sorted.generated.dfns.backwards)


count.zeros=function(x){return(length(which(x==0)))}


omega = function(dfn,sorted.dfns){
  dfn2=dfn
  for (i in 1:(dim(sorted.dfns)[1]-1)){
    dfn2=rbind(dfn2,dfn)
  }
  n=length(dfn)
  result=which(apply(round(sorted.dfns-dfn2,6),1,count.zeros)==n)/
      dim(sorted.dfns)[1]
  return(result)
}


f = function(x){1-x}


AB = function(A,w,f){
  return(ifelse(A>0,A+f(w)*(1-A),0))
}

# dfn11
# AB11=AB(c(0,0.2,0.6,1,1,0.6),119/126,f)
# paste(round(AB11,6),collapse=",")
# 
# # 1,1
# (AB11 = AB(c(0,0,0,0.6,1,1,0.6,0,0,0),0.8178072,f))
# paste(round(AB11,3),collapse=",")
# 
# # 1,2
# (AB12 = AB(c(0,0,0,0,0,0,0.4,1,0.4,0),0.9230769,f))
# paste(c(0,0,0,0,0,0,0.4,1,0.4,0),collapse=",")
# paste(round(AB12,3),collapse=",")
# 
# 
# # 1,3
# (AB13 = AB(c(0.2,1,0.2,0,0,0,0,0,0,0),0.9868881,f))
# paste(c(0.2,1,0.2,0,0,0,0,0,0,0),collapse=",")
# paste(round(AB13,3),collapse=",")
# 
# 
# # 2,1
# (AB21 = AB(c(0,0,0,0,0,0.4,1,0.4,0,0),0.9547952,f))
# paste(c(0,0,0,0,0,0.4,1,0.4,0,0),collapse=",")
# paste(round(AB21,3),collapse=",")
# 
# # 2,2
# (AB22 = AB(c(0,0,0,0,0,0,0,0.2,1,0.2),0.9868881,f))
# paste(c(0,0,0,0,0,0,0,0.2,1,0.2),collapse=",")
# paste(round(AB22,3),collapse=",")
# 
# 
# # 2,3
# (AB23 = AB(c(0,0.4,1,0.4,0,0,0,0,0,0),0.8571429,f))
# paste(c(0,0.4,1,0.4,0,0,0,0,0,0),collapse=",")
# paste(round(AB23,3),collapse=",")
# 
# # 3,1
# (AB31 = AB(c(0,0,0,0,0,0,0.4,1,0.4,0),0.9547952,f))
# paste(c(0,0,0,0,0,0,0.4,1,0.4,0),collapse=",")
# paste(round(AB31,3),collapse=",")
# 
# # 3,2
# (AB32 = AB(c(0,0,0,0,0,0,0.6,1,1,1),0.8178072,f))
# paste(c(0,0,0,0,0,0,0.4,1,0.4,0),collapse=",")
# paste(round(AB32,3),collapse=",")
# 
# # 3,3
# (AB33 = AB(c(0,0,0.6,1,0.6,0,0,0,0,0),0.9711538,f))
# paste(c(0,0,0.6,1,0.6,0,0,0,0,0),collapse=",")
# paste(round(AB33,3),collapse=",")
