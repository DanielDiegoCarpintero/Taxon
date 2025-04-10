************************************************************************
      PROGRAM driver
* It integrates and classifies orbits.
************************************************************************
      INTEGER ndim,ndimf
      PARAMETER (ndim=2,ndimf=2*ndim)

* COMMON with orbit.for
      INTEGER iascii,ibin,icom,ipan,isub,itipo,n,rkbs,perx,isos,nsos
      DOUBLE PRECISION del,perif,t0,tf,x0,xc,yc
      CHARACTER archi*30
      COMMON /entradas/t0,tf,del,x0(ndimf),perif,xc,yc,rkbs,itipo,n,
     & nsos,perx,iascii,ibin,icom,isos,ipan,isub,archi

* COMMON with taxon.for
      INTEGER jsub,jdim,jcla,jcl,jpan,jlin,jcom
      CHARACTER arch*30
      COMMON /input/jsub,jdim,jcla,jcl,jpan,jlin,jcom,arch

* Local variables
      INTEGER i

* Input parameters: orbit.for
      itipo=1 ! =1 end by points; =2 time; =3 periods; =4 points on SOS
      t0=0d0 ! initial time
      tf=1500d0 ! final time (itipo=1,2)
      n=8192 ! number of points to integrate (itipo=1)
      del=1d0 ! step of integration (itipo=2,3,4)
      perif=100d0 ! periods to integrate (itipo=3)
      perx=1 ! =1 x-periods, =2 vx-periods, =3 radial periods (itipo=3)
      nsos=100 ! number of points on the SOSs to integrate (itipo=4)
      xc=0d0 ! x-plane of one SOS (itipo=4)
      yc=0d0 ! y-plane of the other SOS (itipo=4)
      rkbs=1 ! use Runge-Kutta (=1) or Bulirsch-Stoer (=2)
      iascii=0 ! nascii output
      ibin=0 ! binary output
      icom=1 ! COMMON output
      isos=0 ! =0 no SOS; =1 ZVC+SOS; =2 ZVC+accumulated SOS; =3 SOS
      ilya=0 ! don't compute Lyapunov exponents
      ipan=0 ! screen output
      isub=1 ! use orbit.for as a subroutine
* Input parameters: taxon.for
      jsub=1 ! use taxon.for as a subroutine
      jdim=ndim ! dimension of the potential
      jcla=1 ! dump classification to file
      jcl=0 ! dump abridged classification to file
      jpan=1 ! write to screen
      jlin=0 ! dump line spectra
      jcom=1 ! get orbit from COMMON
      arch='binney' ! prefix for output files

* Example of loop over values on the x-axis
      OPEN(50,FILE='inbinney.dat')
      i=0
      DOWHILE(.TRUE.)
         READ(50,*,END=1)x0
         i=i+1
         PRINT '(a,i4)','Orbit # ',i
         CALL orbit
         CALL taxon
      ENDDO
1     END

      INCLUDE 'orbit.for'
      INCLUDE 'taxon.for'
