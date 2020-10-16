FROM postgres:12.4-alpine
#This all on one line to keep the number of layers down and keep the size of this container small. 
# The APK del needs to run on the same line as the add to see a benefit from it.

RUN apk add --no-cache --virtual .build-deps postgresql-dev build-base git && \
    git clone https://github.com/pgaudit/pgaudit.git && \
    cd pgaudit && \
    git checkout REL_12_STABLE && \
    make check USE_PGXS=1 && \
    make install USE_PGXS=1 && \ 
    apk del .build-deps && \
    rm -rf pgaudit