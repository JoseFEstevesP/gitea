# Use the official Gitea image as base
FROM gitea/gitea:latest

# Set up non-root user with proper permissions
RUN apk add --no-cache bash

# Create and set the data directory
ENV GITEA_CUSTOM=/data/gitea
RUN mkdir -p /data/git/repositories \
    && chown -R git:git /data \
    && chmod -R 755 /data

# Expose ports
EXPOSE 3000 22

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD ["wget", "--quiet", "--tries=1", "--spider", "http://localhost:3000/healthcheck"]

# Run as git user
USER git

# Set the entrypoint
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]